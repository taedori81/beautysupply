

from oscar.apps.catalogue.abstract_models import AbstractProduct, AbstractProductAttributeValue
from operator import itemgetter


class Product(AbstractProduct):
    def secondary_image(self):
        images = self.images.all()
        ordering = self.images.model.Meta.ordering
        if not ordering or ordering[0] != "display_order":
            # Only apply order_by() if a custom model doesn't use default
            # ordering. Applying order_by() busts the prefetch cache of
            # the ProductManager
            images = images.order_by('display_order')
        try:
            return images[1]
        except IndexError:
            # We return a dict with fields that mirror the key properties of
            # the ProductImage class so this missing image can be used
            # interchangeably in templates.  Strategy pattern ftw!
            return {
                'original': self.get_missing_image(),
                'caption': '',
                'is_missing': True}

    def attribute_summary_sorted(self):
        """
        Return a string of all of a product's attributes but Length First order

        """
        attributes = self.attribute_values.all()
        pairs = [attribute.summary_sorted() for attribute in attributes]
        sorted_pairs = tuple(sorted(pairs, key=itemgetter(1)))
        return ', '.join(sorted_pairs)


class ProductAttributeValue(AbstractProductAttributeValue):

    def summary_sorted(self):
        if self.attribute.name == "Length":
            return u"%s" % self.value_as_text
        return u"%s: %s" % (self.attribute.name, self.value_as_text)

from oscar.apps.catalogue.models import *