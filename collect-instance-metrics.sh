METRICS="instance:etcd_object_counts:sum instance:node_cpu:rate:sum instance:node_cpu:ratio instance:node_cpu_utilisation:rate1m instance:node_filesystem_usage:sum instance:node_load1_per_cpu:ratio instance:node_memory_utilisation:ratio instance:node_network_receive_bytes:rate:sum instance:node_network_receive_bytes_excluding_lo:rate1m instance:node_network_receive_drop_excluding_lo:rate1m instance:node_network_transmit_bytes:rate:sum instance:node_network_transmit_bytes_excluding_lo:rate1m instance:node_network_transmit_drop_excluding_lo:rate1m instance:node_num_cpu:sum instance:node_vmstat_pgmajfault:rate1m instance_device:node_disk_io_time_seconds:rate1m instance_device:node_disk_io_time_weighted_seconds:rate1m"
OUTDIR=metrics/instance
PERIOD=${PERIOD:-6h}
mkdir -p $OUTDIR
for METRIC in $METRICS; do
oc exec -c prometheus -n openshift-monitoring prometheus-k8s-0 -- curl --data-urlencode "query=$METRIC[$PERIOD]" http://localhost:9090/api/v1/query > $OUTDIR/$METRIC
done
