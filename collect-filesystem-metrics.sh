METRICS="node_filesystem_avail_bytes node_filesystem_device_error node_filesystem_files node_filesystem_files_free node_filesystem_free_bytes node_filesystem_readonly node_filesystem_size_bytes"
OUTDIR=stats/filesystem
PERIOD=6h
mkdir -p $OUTDIR
for METRIC in $METRICS; do
oc exec -c prometheus -n openshift-monitoring prometheus-k8s-0 -- curl --data-urlencode "query=$METRIC[$PERIOD]" http://localhost:9090/api/v1/query > $OUTDIR/$METRIC
done
