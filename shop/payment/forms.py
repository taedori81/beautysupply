import re
from calendar import monthrange
from datetime import date

from django import forms
from django.forms.widgets import TextInput
from django.forms import widgets
from django.core.exceptions import ImproperlyConfigured
from django.utils.translation import ugettext_lazy as _

from oscar.apps.address.forms import AbstractAddressForm
from oscar.core.loading import get_model
from oscar.views.generic import PhoneNumberMixin

from oscar.apps.payment import bankcards
from oscar.apps.payment.forms import BankcardForm as CoreBankcardForm
from oscar.apps.payment.forms import BankcardCCVField as CoreBankcardCCVField
from oscar.apps.payment.forms import BankcardNumberField as CoreBankcardNumberField
from oscar.apps.payment.forms import BankcardMonthField as CoreBankcardMonthField
from oscar.apps.payment.forms import BankcardExpiryMonthField as CoreBankcardExpiryMonthField
from oscar.apps.payment.forms import BankcardMonthWidget

Bankcard = get_model('payment', 'Bankcard')


# class SensitiveTextInput(TextInput):
#     def build_attrs(self, extra_attrs=None, **kwargs):
#         attrs = super(SensitiveTextInput, self).build_attrs(extra_attrs, **kwargs)
#         if 'name' in attrs:
#             del attrs['name']


class BankcardNumberField(CoreBankcardNumberField):
    def __init__(self, *args, **kwargs):
        _kwargs = {
            'max_length': 20,
            'widget': forms.TextInput(attrs={'autocomplete': 'off',
                                             'class': 'card-number',
                                             'id': 'card-Number',
                                             'name': 'hello'}),
            'label': _("Card number")
        }
        if 'types' in kwargs:
            self.accepted_cards = set(kwargs.pop('types'))
            difference = self.accepted_cards - VALID_CARDS
            if difference:
                raise ImproperlyConfigured('The following accepted_cards are '
                                           'unknown: %s' % difference)

        _kwargs.update(kwargs)
        super(BankcardNumberField, self).__init__(*args, **_kwargs)

    def clean(self, value):
        """
        Check if given CC number is valid and one of the
        card types we accept
        """
        non_decimal = re.compile(r'\D+')
        value = non_decimal.sub('', value.strip())

        if value and not bankcards.luhn(value):
            raise forms.ValidationError(
                _("Please enter a valid credit card number."))

        if hasattr(self, 'accepted_cards'):
            card_type = bankcards.bankcard_type(value)
            if card_type not in self.accepted_cards:
                raise forms.ValidationError(
                    _("%s cards are not accepted." % card_type))

        return super(BankcardNumberField, self).clean(value)


class BankcardCCVField(forms.RegexField):
    def __init__(self, *args, **kwargs):
        _kwargs = {
            'required': True,
            'label': _("CCV number"),
            'widget': forms.TextInput(attrs={'size': '5', 'class': 'ccv-number'}),
            'error_message': _("Please enter a 3 or 4 digit number"),
            'help_text': _("This is the 3 or 4 digit security number "
                           "on the back of your bankcard")
        }
        _kwargs.update(kwargs)
        super(BankcardCCVField, self).__init__(
            r'^\d{3,4}$', *args, **_kwargs)

    def clean(self, value):
        if value is not None:
            value = value.strip()
        return super(BankcardCCVField, self).clean(value)


class BankcardMonthField(CoreBankcardMonthField):
    """
    A modified version of the snippet: http://djangosnippets.org/snippets/907/
    """
    default_error_messages = {
        'invalid_month': _('Enter a valid month.'),
        'invalid_year': _('Enter a valid year.'),
    }
    num_years = 5

    def __init__(self, *args, **kwargs):
        # Allow the number of years to be specified
        if 'num_years' in kwargs:
            self.num_years = kwargs.pop('num_years')

        errors = self.default_error_messages.copy()
        if 'error_messages' in kwargs:
            errors.update(kwargs['error_messages'])

        fields = (
            forms.ChoiceField(
                choices=self.month_choices(),
                error_messages={'invalid': errors['invalid_month']}),
            forms.ChoiceField(
                choices=self.year_choices(),
                error_messages={'invalid': errors['invalid_year']}),
        )
        if 'widget' not in kwargs:
            kwargs['widget'] = BankcardMonthWidget(
                widgets=[fields[0].widget, fields[1].widget])
        super(BankcardMonthField, self).__init__(fields, *args, **kwargs)

    def month_choices(self):
        return []

    def year_choices(self):
        return []


class BankcardExpiryMonthField(CoreBankcardExpiryMonthField):
    num_years = 10

    def __init__(self, *args, **kwargs):
        today = date.today()
        _kwargs = {
            'required': True,
            'label': _("Expiration Date"),
            'initial': ["%.2d" % today.month, today.year]
        }
        _kwargs.update(kwargs)
        super(BankcardExpiryMonthField, self).__init__(*args, **_kwargs)

    def month_choices(self):
        return [("%.2d" % x, "%.2d" % x) for x in range(1, 13)]

    def year_choices(self):
        return [(x, x) for x in range(
            date.today().year,
            date.today().year + self.num_years)]

    def clean(self, value):
        expiry_date = super(BankcardExpiryMonthField, self).clean(value)
        if date.today() > expiry_date:
            raise forms.ValidationError(
                _("The expiration date you entered is in the past."))
        return expiry_date

    def compress(self, data_list):
        if data_list:
            if data_list[1] in forms.fields.EMPTY_VALUES:
                error = self.error_messages['invalid_year']
                raise forms.ValidationError(error)
            if data_list[0] in forms.fields.EMPTY_VALUES:
                error = self.error_messages['invalid_month']
                raise forms.ValidationError(error)
            year = int(data_list[1])
            month = int(data_list[0])
            # find last day of the month
            day = monthrange(year, month)[1]
            return date(year, month, day)
        return None


FIELD_NAME_MAPPINGS = {
    'number': '',
    'ccv': '',
    'expiry_month_0': '',
    'expiry_month_1': '',
}

from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit, Layout, Field, MultiWidgetField


class BankcardForm(forms.ModelForm):
    # By default, this number field will accept any number. The only validation
    # is whether it passes the luhn check. If you wish to only accept certain
    # types of card, you can pass a types kwarg to BankcardNumberField, e.g.
    #
    # BankcardNumberField(types=[bankcards.VISA, bankcards.VISA_ELECTRON,])

    def __init__(self, *args, **kwargs):
        super(BankcardForm, self).__init__(*args, **kwargs)
        # Crispy Form
        # self.helper = FormHelper()
        # self.helper.form_id = "bankcard-form"
        # self.helper.form_class = "bankcard-form"
        # self.helper.form_action = "checkout:preview"
        # self.helper.layout = Layout(
        #     Field('number', name='', id='cardNumber', css_class='cardNumber'),
        #     MultiWidgetField('expiry_month', name=''),
        #     Field('ccv', name='', id='ccvNumber', css_class='ccvNumber'),
        # )
        # self.helper.add_input(Submit('submit', 'Submit'))

    # def add_prefix(self, field_name):
    #     field_name = FIELD_NAME_MAPPINGS.get(field_name, field_name)
    #     return super(BankcardForm, self).add_prefix(field_name)

    number = BankcardNumberField()
    expiry_date = BankcardExpiryMonthField()
    ccv = BankcardCCVField()

    class Meta:
        model = Bankcard
        fields = ['number', 'expiry_date', 'ccv']

    def clean(self):
        data = self.cleaned_data
        number, ccv = data.get('number'), data.get('ccv')
        if number and ccv:
            if bankcards.is_amex(number) and len(ccv) != 4:
                raise forms.ValidationError(_(
                    "American Express cards use a 4 digit security code"))
        return data

    def save(self, *args, **kwargs):
        # It doesn't really make sense to save directly from the form as saving
        # will obfuscate some of the card details which you normally need to
        # pass to a payment gateway.  Better to use the bankcard property below
        # to get the cleaned up data, then once you've used the sensitive
        # details, you can save.
        raise RuntimeError("Don't save bankcards directly from form")

    @property
    def bankcard(self):
        """
        Return an instance of the Bankcard model (unsaved)
        """
        return Bankcard(number=self.cleaned_data['number'],
                        expiry_date=self.cleaned_data['expiry_month'],
                        # start_date=self.cleaned_data['start_month'],
                        ccv=self.cleaned_data['ccv'])

