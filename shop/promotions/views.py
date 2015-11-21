from django.core.urlresolvers import reverse
from django.views.generic import RedirectView, TemplateView

from oscar.apps.promotions.views import HomeView as CoreHomeView
from oscar.core.loading import get_model

Product = get_model('catalogue', 'product')


class HomeView(CoreHomeView):
    """
    This is the home page and will typically live at /
    """
    template_name = 'promotions/home.html'

    def get_context_data(self, **kwargs):

        ctx = {}
        ctx['products'] = Product.objects.all()
        return ctx
