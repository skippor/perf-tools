#!/bin/bash

echo "Stack collapse ..."
../stackcollapse-perf.pl "./${cur_dir}/perf.unflold" > "./${cur_dir}/perf.folded"
echo "Flame graph ..."
../flamegraph.pl "./${cur_dir}/perf.folded" > "./${cur_dir}/perf.svg"

