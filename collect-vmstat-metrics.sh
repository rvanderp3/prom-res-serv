METRICS="node_vmstat_oom_kill node_vmstat_pgfault node_vmstat_pgmajfault node_vmstat_pgpgin node_vmstat_pgpgout node_vmstat_pswpin node_vmstat_pswpout"
OUTDIR=stats/vmstat
PERIOD=6h
mkdir -p $OUTDIR
for METRIC in $METRICS; do
oc exec -c prometheus -n openshift-monitoring prometheus-k8s-0 -- curl --data-urlencode "query=$METRIC[$PERIOD]" http://localhost:9090/api/v1/query > $OUTDIR/$METRIC
done
