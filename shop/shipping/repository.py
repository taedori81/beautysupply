from oscar.apps.shipping import repository

from . import methods


class Repository(repository.Repository):
    methods = (methods.Standard(), methods.Express())

    def get_available_shipping_methods(
            self, basket, shipping_addr=None, **kwargs):

        return self.methods


