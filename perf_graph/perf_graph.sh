#!/bin/bash

FLAME_GRAPH_DIR=./FlameGraph
WEB_PERF_DIR=./

cur_dir=`date "+%F_%T"`
mkdir -p ${cur_dir}

echo "Perf record ..."
#perf record -C 0 -p `pidof -s nginx` -o "./${cur_dir}/perf.dat" -- sleep 30
perf record -g -F 99 -o "./${cur_dir}/perf.dat" -- sleep 30
perf script -i "./${cur_dir}/perf.dat" > "./${cur_dir}/perf.unflold"

echo "Stack collapse ..."
${FLAME_GRAPH_DIR}/stackcollapse-perf.pl "./${cur_dir}/perf.unflold" > "./${cur_dir}/perf.folded"

echo "Flame graph ..."
${FLAME_GRAPH_DIR}/flamegraph.pl "./${cur_dir}/perf.folded" > "./${cur_dir}/perf.svg"

cp "./${cur_dir}/perf.svg" "${WEB_PERF_DIR}/perf-${cur_dir}.svg"