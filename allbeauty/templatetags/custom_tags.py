from django import template

from oscar.core.loading import get_model

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
