from operator import itemgetter

from django import forms
from django.conf import settings
from django.utils.translation import ugettext_lazy as _

from oscar.core.loading import get_model
from oscar.forms import widgets

Line = get_model('basket', 'line')
Basket = get_model('basket', 'basket')
Product = get_model('catalogue', 'product')


class AddToBasketFormCustom(forms.Form):
    quantity = forms.IntegerField(initial=1, min_value=1, label=_('Quantity'))

    def __init__(self, basket, product, *args, **kwargs):
        # Note, the product passed in here isn't necessarily the product being
        # added to the basket. For child products, it is the *parent* product
        # that gets passed to the form. An optional product_id param is passed
        # to indicate the ID of the child product being added to the basket.
        self.basket = basket
        self.parent_product = product

        super(AddToBasketFormCustom, self).__init__(*args, **kwargs)

        # Dynamically build fields
        if product.is_parent or product.is_standalone:
            self._create_parent_product_fields(product)
        self._create_product_fields(product)

    # Dynamic form building methods

    def _create_parent_product_fields(self, product):
        """
        Adds the fields for a "group"-type product (eg, a parent product with a
        list of children.

        Currently requires that a stock record exists for the children
        """
        choices = []
        disabled_values = []
        for child in product.children.all():
            # Build a description of the child, including any pertinent
            # attributes
            attr_summary = child.attribute_summary_sorted()
            if attr_summary:
                summary = attr_summary
            else:
                summary = child.get_title()

            # Check if it is available to buy
            info = self.basket.strategy.fetch_for_product(child)
            if not info.availability.is_available_to_buy:
                disabled_values.append(child.id)

            # Sort by Length!!!
            choices.append((child.id, summary))
            sorted_choices = sorted(choices, key=itemgetter(1))

        self.fields['child_id'] = forms.ChoiceField(
            choices=tuple(sorted_choices), label=_("Options"),
            widget=widgets.AdvancedSelect(disabled_values=disabled_values))

    def _create_product_fields(self, product):
        """
        Add the product option fields.
        """
        for option in product.options:
            self._add_option_field(product, option)

    def _add_option_field(self, product, option):
        """
        Creates the appropriate form field for the product option.

        This is designed to be overridden so that specific widgets can be used
        for certain types of options.
        """
        kwargs = {'required': option.is_required}
        self.fields[option.code] = forms.CharField(**kwargs)

    # Cleaning

    def clean_child_id(self):
        try:
            child = self.parent_product.children.get(
                id=self.cleaned_data['child_id'])
        except Product.DoesNotExist:
            raise forms.ValidationError(
                _("Please select a valid product"))

        # To avoid duplicate SQL queries, we cache a copy of the loaded child
        # product as we're going to need it later.
        self.child_product = child

        return self.cleaned_data['child_id']

    def clean_quantity(self):
        # Check that the proposed new line quantity is sensible
        qty = self.cleaned_data['quantity']
        basket_threshold = settings.OSCAR_MAX_BASKET_QUANTITY_THRESHOLD
        if basket_threshold:
            total_basket_quantity = self.basket.num_items
            max_allowed = basket_threshold - total_basket_quantity
            if qty > max_allowed:
                raise forms.ValidationError(
                    _("Due to technical limitations we are not able to ship"
                      " more than %(threshold)d items in one order. Your"
                      " basket currently has %(basket)d items.")
                    % {'threshold': basket_threshold,
                       'basket': total_basket_quantity})
        return qty

    @property
    def product(self):
        """
        The actual product being added to the basket
        """
        # Note, the child product attribute is saved in the clean_child_id
        # method
        return getattr(self, 'child_product', self.parent_product)

    def clean(self):
        info = self.basket.strategy.fetch_for_product(self.product)

        # Check currencies are sensible
        if (self.basket.currency and
                info.price.currency != self.basket.currency):
            raise forms.ValidationError(
                _("This product cannot be added to the basket as its currency "
                  "isn't the same as other products in your basket"))

        # Check user has permission to add the desired quantity to their
        # basket.
        current_qty = self.basket.product_quantity(self.product)
        desired_qty = current_qty + self.cleaned_data.get('quantity', 1)
        is_permitted, reason = info.availability.is_purchase_permitted(
            desired_qty)
        if not is_permitted:
            raise forms.ValidationError(reason)

        return self.cleaned_data

    # Helpers

    def cleaned_options(self):
        """
        Return submitted options in a clean format
        """
        options = []
        for option in self.parent_product.options:
            if option.code in self.cleaned_data:
                options.append({
                    'option': option,
                    'value': self.cleaned_data[option.code]})
        return options


class SimpleAddToBasketFormCustom(AddToBasketFormCustom):
    """
    Simplified version of the add to basket form where the quantity is
    defaulted to 1 and rendered in a hidden widget
    """
    quantity = forms.IntegerField(
        initial=1, min_value=1, widget=forms.HiddenInput, label=_('Quantity'))

