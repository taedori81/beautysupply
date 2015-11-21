from django.db import models

from oscar.apps.catalogue.abstract_models import AbstractProduct


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

from oscar.apps.catalogue.models import *