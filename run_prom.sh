#!/bin/bash

podman run --net="host" --pid="host" --mount=type=bind,src=/,dst=/host,ro=true,bind-propagation=rslave --detach quay.io/prometheus/node-exporter:latest --path.rootfs=/host
podman run --mount=type=bind,src=$(pwd)/data,dst=/etc/prometheus,relabel=shared --net="host" --detach prometheus:latest

sleep 10
firefox http://localhost:9090/graph?g0.expr=rate(node_cpu_seconds_total%7Bmode%3D%22system%22%7D%5B1m%5D)&g0.tab=0&g0.stacked=0&g0.range_input=1h
