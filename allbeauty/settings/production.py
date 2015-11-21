from .base import *


DEBUG = False
TEMPLATE_DEBUG = False

AVALARA_TEST_MODE = False

try:
    from .local import *
except ImportError:
    pass
