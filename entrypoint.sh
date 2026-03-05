#!/bin/sh
set -e

COUCH_URL="${COUCH_URL:-http://127.0.0.1:5984}"
COUCH_USER="${COUCH_USER:-admin}"
COUCH_PASS="${COUCH_PASS:-admin}"

echo "▶ Attendo CouchDB su $COUCH_URL ..."
until curl -s "$COUCH_URL" >/dev/null; do
  sleep 1
done

echo "▶ Enable single-node cluster"
curl -u "$COUCH_USER:$COUCH_PASS" \
  -X POST "$COUCH_URL/_cluster_setup" \
  -H "Content-Type: application/json" \
  -d "{
    \"action\": \"enable_single_node\",
    \"username\": \"$COUCH_USER\",
    \"password\": \"$COUCH_PASS\",
    \"bind_address\": \"0.0.0.0\",
    \"port\": 5984
  }"

echo
echo "▶ Finish cluster setup"
curl -u "$COUCH_USER:$COUCH_PASS" \
  -X POST "$COUCH_URL/_cluster_setup" \
  -H "Content-Type: application/json" \
  -d '{ "action": "finish_cluster" }'

echo
echo "▶ Verifica stato cluster"
curl -u "$COUCH_USER:$COUCH_PASS" \
  "$COUCH_URL/_cluster_setup"

echo
echo "✔ Cluster setup completato"
