from .base import *


DEBUG = False
TEMPLATE_DEBUG = False

AVALARA_TEST_MODE = False

# Parse database configuration from $DATABASE_URL

DATABASES['default'] = dj_database_url.config()

# Enable Connection Pooling (if desired)
DATABASES['default']['ATOMIC_REQUESTS'] = True # for oscar
DATABASES['default']['CONN_MAX_AGE'] = 500


# Honor the 'X-Forwarded-Proto' header for request.is_secure()
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

# Allow all host headers
ALLOWED_HOSTS = ['*']

try:
    from .local import *
except ImportError:
    pass