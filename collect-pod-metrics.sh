if [ -z "$1" ]; then
echo Must provide a pod name
exit
fi

prom_query() {
    oc exec -c prometheus -n openshift-monitoring prometheus-k8s-0 -- curl --data-urlencode $@ http://localhost:9090/api/v1/query
}

pod="$1"
OUTDIR=metrics/pod/$pod
period=${PERIOD:-6h}
mkdir -p $OUTDIR

export stats="container_cpu_usage container_fs_usage_bytes container_spec_cpu_shares container_memory_usage_bytes"
for stat in $stats; do prom_query "query=pod:$stat:sum{pod=\"$pod\"}[$period]" > $OUTDIR/$stat;done
prom_query "query=rate(container_fs_writes_bytes_total{pod=\"$pod\"}[$period])"  > $OUTDIR/container_fs_writes_bytes_total
prom_query "query=rate(container_fs_reads_bytes_total{pod=\"$pod\"}[$period])"  > $OUTDIR/container_fs_reads_bytes_total
export stats="container_cpu_usage_seconds_total container_fs_io_current container_memory_failcnt container_memory_failures_total"
for stat in $stats; do prom_query "query=$stat{pod=\"$pod\"}[$period]"  > $OUTDIR/$stat; done
export stats="container_cpu_cfs_throttled_seconds_total container_network_receive_bytes_total container_network_transmit_bytes_total container_fs_reads_bytes_total container_fs_writes_bytes_total"
for stat in $stats; do prom_query "query=$stat{pod=\"$pod\"}[$period]"  > $OUTDIR/$stat; done
