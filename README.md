When working with exported query results, sometimes you just want to view that data in Grafana. The aim of this project is to make prometheus query results easy to consume in Grafana.  

1. Collect output of prometheus queries:
~~~
period=6h
prom_query() {
    curl --data-urlencode $@ http://localhost:9090/api/v1/query
}

prom_query "query=instance:node_cpu_utilisation:rate1m[$period]"  > cpu_utilization
prom_query "query=instance_device:node_disk_io_time_seconds:rate1m[$period]"  > disk_io
~~~

2. Start up the result server:

~~~
python result-serv.py
~~~

Note: The result server starts up on port 8000

3. Add the result server as a Prometheus datasource in Grafana

4. Create a query.  The name of the metric you provide corresponds to the result file being served.  

The sole role of the metric server is to map a metric name to a result file.  


# Using the collection scripts

## Collecting metrics 

1. Login with `oc`

2. Run the script of choice

3. Metrics will be output to the `metrics` folder

## Using a custom collection period
export PERIOD=6h

## Accessing the metrics with the `result-serv`

Start `result-serv.py` in the directory containing the collected metrics files .  
