from oscar.apps.shipping import methods as oscar_methods
from decimal import Decimal as D


class Standard(oscar_methods.FixedPrice):
    code = "standard"
    name = "Standard"
    charge_excl_tax = D('10.00')


class Express(oscar_methods.FixedPrice):
    code = "express"
    name = "Express"
    charge_excl_tax = D('20.00')