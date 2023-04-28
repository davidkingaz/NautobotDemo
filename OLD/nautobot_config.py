# nautobot_config.py
import os
from nautobot.core.settings import *  # noqa

ALLOWED_HOSTS = ["*"]

DATABASES = {
    "default": {
        "NAME": "nautobot",
        "USER": "nautobot",
        "PASSWORD": os.environ.get("postgres_pwd", ""),
        "HOST": "db",
        "PORT": "",
        "CONN_MAX_AGE": 300,
        "ENGINE": "django.db.backends.postgresql",
    }
}

SECRET_KEY = "${NAUTOBOT_SECRET_KEY}""

# HTTP/HTTPS settings
# HTTP_PORT = 80
# HTTPS_PORT = 443
# SSL_CERTIFICATE = '/etc/ssl/certs/your-cert.pem'
# SSL_PRIVATE_KEY = '/etc/ssl/private/your-key.pem'
