ROUTES=`oc get route -A -o=jsonpath='{.items[*].metadata.name}'`
METRICS="haproxy_server_http_average_response_latency_milliseconds haproxy_backend_http_average_response_latency_milliseconds haproxy_server_http_average_connect_latency_milliseconds haproxy_backend_http_average_connect_latency_milliseconds haproxy_server_http_average_queue_latency_milliseconds haproxy_backend_http_average_queue_latency_milliseconds haproxy_server_current_queue haproxy_backend_current_queue haproxy_server_connections_total"
OUTDIR=metrics/haproxy
PERIOD=${PERIOD:-6h}
mkdir -p $OUTDIR
for ROUTE in $ROUTES; do
for METRIC in $METRICS; do
oc exec -c prometheus -n openshift-monitoring prometheus-k8s-0 -- curl --data-urlencode "query=$METRIC{route=\"$ROUTE\"}[$PERIOD]" http://localhost:9090/api/v1/query > $OUTDIR/$   ROUTE_$METRIC
done
done