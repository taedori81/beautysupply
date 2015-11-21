from oscar.apps.checkout import session
from .. import tax
from django.contrib import messages
from django.template import loader

import avalara


# Override the session mixin (which every checkout view uses) so we can apply
# takes when the shipping address is known.
class CheckoutSessionMixin(session.CheckoutSessionMixin):

    def build_submission(self, **kwargs):
        submission = super(CheckoutSessionMixin, self).build_submission(
            **kwargs)

        if submission['shipping_address'] and submission['shipping_method']:
            tax.apply_to(submission)

            # Recalculate order total to ensure we have a tax-inclusive total
            submission['order_total'] = self.get_order_totals(
                submission['basket'], submission['shipping_charge'])

        # Using avalara
        # try:
        #     avalara.apply_taxes_to_submission(submission)
        #
        # except avalara.InvalidAddress as e:
        #     msg = loader.render_to_string(
        #         'avalara/messages/invalid_address.html',
        #         {'error': e.message})
        #     messages.error(self.request, msg, extra_tags="safe noicon")

        return submission

    def get_context_data(self, **kwargs):
        ctx = super(CheckoutSessionMixin, self).get_context_data(**kwargs)

        # Oscar's checkout templates look for this variable which specifies to
        # break out the tax totals into a separate subtotal.
        ctx['show_tax_separately'] = True

        return ctx
