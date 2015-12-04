from django import template

from oscar.core.loading import get_model, get_class

register = template.Library()
Category = get_model('catalogue', 'category')


@register.assignment_tag(name="category_list")
def build_navigation():
    categories = Category.get_tree()
    for node in categories:
        if node.get_children_count() > 0:
            node.has_children = True
        else:
            node.has_children = False

    return categories


AddToBasketFormCustom = get_class('basket.forms', 'AddToBasketFormCustom')
SimpleAddToBasketFormCustom = get_class('basket.forms', 'SimpleAddToBasketFormCustom')
Product = get_model('catalogue', 'product')
QNT_SINGLE, QNT_MULTIPLE = 'single', 'multiple'


@register.assignment_tag(name="basket_form_custom")
def basket_form_custom(request, product, quantity_type='single'):
    if not isinstance(product, Product):
        return ''

    initial = {}
    if not product.is_parent:
        initial['product_id'] = product.id

    form_class = AddToBasketFormCustom
    if quantity_type == QNT_SINGLE:
        form_class = SimpleAddToBasketFormCustom

    form = form_class(request.basket, product=product, initial=initial)

    return form


@register.assignment_tag(name="product_reivews")
def reviews_for_product(request, product):
    return product.reviews.all()

