#!/bin/bash

FLAME_GRAPH_DIR=../FlameGraph

cur_dir=`date "+%F_%T"`
mkdir -p ${cur_dir}

echo "Stack record ..."
perf record -C 0 -p `pidof nginx` -o "./${cur_dir}/perf.dat" -- sleep 30
perf script -i "./${cur_dir}/perf.dat" > "./${cur_dir}/perf.unflold"

echo "Stack collapse ..."
../stackcollapse-perf.pl "./${cur_dir}/perf.unflold" > "./${cur_dir}/perf.folded"

echo "Flame graph ..."
../flamegraph.pl "./${cur_dir}/perf.folded" > "./${cur_dir}/perf.svg"

