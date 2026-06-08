#!/bin/sh

TEMPLATE="/aton/wapps/heriverse/config/Utils.template.js"
OUTPUT="/aton/wapps/heriverse/config/Utils.js"

cp "$TEMPLATE" "$OUTPUT"

# sostituisce tutte le variabili d'ambiente nel formato $VAR
for var in $(env | cut -d= -f1); do
  value=$(printenv "$var")

  # escape per sed
  esc_value=$(printf '%s\n' "$value" | sed 's/[\/&]/\\&/g')

  sed -i "s|\$$var|$esc_value|g" "$OUTPUT"
done

exec "$@"