#!/bin/sh

case "${1:-}" in
    "apache2")
        exec /usr/bin/tini -- apache2ctl -D FOREGROUND
        ;;
    "php-fpm")
        exec /usr/bin/tini -- /usr/local/sbin/php-fpm
        ;;
    "/bin/sh" | "sh" | "/bin/bash" | "bash" )
        exec "$@"
        ;;
    *)
        echo "Usage: ${0} {php-fpm|bash|sh}" >&2
        exit 3
        ;;
esac
