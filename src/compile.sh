#! /bin/sh
set -e
cp inst.S ../tools/code_gener/
cd ../tools/code_gener
make inst.mem
cd ../../src
if [ $# != 1 ]; then
	cp ../tools/code_gener/inst.mem ./CPU.srcs/sim_1/new/
else
	cp ../tools/code_gener/inst.mem ./CPU.srcs/sim_1/new/$1.mem
fi
