
from django.conf import settings
from django.utils.translation import ugettext as _
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt

from oscar.apps.checkout import views

from oscar.apps.payment.models import SourceType, Source
from ..payment.forms import BankcardForm
from oscar.core.loading import get_model
from oscar.apps.payment.forms import BankcardForm as CoreBankcardForm


from .facade import Facade
from .forms import StripeTokenForm
from . import PAYMENT_METHOD_STRIPE, PAYMENT_EVENT_PURCHASE, STRIPE_EMAIL, STRIPE_TOKEN
# import avalara
#
SourceType = get_model('payment', 'SourceType')
Source = get_model('payment', 'Source')


class PaymentDetailsView(views.PaymentDetailsView):

    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(PaymentDetailsView, self).dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        ctx = super(PaymentDetailsView, self).get_context_data(**kwargs)
        if self.preview:
            ctx['stripe_token_form'] = StripeTokenForm(self.request.POST)
            ctx['order_total_incl_tax_cents'] = (ctx['order_total'].incl_tax * 100).to_integral_value()
        else:
            ctx['stripe_publishable_key'] = settings.STRIPE_PUBLISHABLE_KEY
            ctx['bankcard_form'] = BankcardForm(self.request.POST)
        return ctx

    def post(self, request, *args, **kwargs):
        # Override so we can validate the bankcard/billingaddress submission.
        # If it is valid, we render the preview screen with the forms hidden
        # within it.  When the preview is submitted, we pick up the 'action'
        # parameters and actually place the order.

        bankcard_form = BankcardForm(request.POST)
        # TODO Add Later
        # billing_address_form = BillingAddressForm(request.POST)

        # if not all([bankcard_form.is_valid(),]):
        #     # Form validation failed, render page again with errors
        #     self.preview = False
        #     ctx = self.get_context_data(
        #         bankcard_form=bankcard_form)
        #     return self.render_to_response(ctx)
        #
        # # Render preview with bankcard and billing address details hidden
        # return self.render_preview(request,
        #                            bankcard_form=bankcard_form)

        if bankcard_form.is_valid():
            return self.render_preview(request,
                                       bankcard_form=bankcard_form)
        self.preview = False
        ctx = self.get_context_data(
                bankcard_form=BankcardForm())
        return self.render_to_response(ctx)


    def handle_payment(self, order_number, total, **kwargs):
        stripe_ref = Facade().charge(
            order_number,
            total,
            card=self.request.POST[STRIPE_TOKEN],
            description=self.payment_description(order_number, total, **kwargs),
            metadata=self.payment_metadata(order_number, total, **kwargs))

        source_type, __ = SourceType.objects.get_or_create(name=PAYMENT_METHOD_STRIPE)
        source = Source(
            source_type=source_type,
            currency=settings.STRIPE_CURRENCY,
            amount_allocated=total.incl_tax,
            amount_debited=total.incl_tax,
            reference=stripe_ref)

        self.add_payment_source(source)
        self.add_payment_event(PAYMENT_EVENT_PURCHASE, total.incl_tax)

    def payment_description(self, order_number, total, **kwargs):
        return self.request.POST[STRIPE_EMAIL]

    def payment_metadata(self, order_number, total, **kwargs):
        return {'order_number': order_number}
