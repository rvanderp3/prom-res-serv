END_TIME=$(date +%s)
START_TIME=$(date --date="30 minutes ago" +%s)

oc exec -c prometheus -n openshift-monitoring prometheus-k8s-0 -- curl --data-urlencode "query=histogram_quantile(0.9999, sum(rate(etcd_disk_backend_commit_duration_seconds_bucket{job=\"etcd\"}[2m])) by (instance, le))" --data-urlencode "step=10" --data-urlencode "start=$START_TIME" --data-urlencode "end=$END_TIME" http://localhost:9090/api/v1/query_range > etcd_disk_backend_commit_duration_seconds_bucket
