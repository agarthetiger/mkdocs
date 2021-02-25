# OpenShift Monitoring

OpenShift ships with built-in monitoring for the cluster, which runs in the `openshift-monitoring` namespace. This includes Prometheus, AlertManager and Grafana. 

Openshift uses node-exporter to monitor the nodes in a cluster, which has a 15s scrape internal. This can be checked using the Route exposed for Prometheus on the /config endpoint. 

The scrape internal has implications on the appropriate time intervals used for the PromQL rate() and irate() functions. 
