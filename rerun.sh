#!/bin/bash

# ./run.sh hector 50 -> rerun hector for 50 times
# ./run.sh hbase 8 -> rerun hbase for 8 times
# ./run.sh ninja 3 -> runs ninja for 3 times

# results will be in the folder called `results

if [ ! $# -eq 2 ]
  then
      echo "Error with arguments supplied"
      echo "Usage: $> ./run.sh <project-name> <number-of-reruns>"
      echo "you can see the <project-name> in the file project-names.txt"
      echo "Example:"
      echo "./run.sh hector 50"
      exit 1
fi

name=$1
runs=$2


# fix permission denied docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

#create folder to logs
resultsdir="results/$name_exp$exp/"
mkdir -p $resultsdir

echo "running project $name, with exp$exp for $runs time(s)"

docker run --rm -v ${PWD}/$resultsdir:/noise/RESULTS_flakeflagger --entrypoint "/noise/entrypoint_flakeflagger.sh" denini/noise-instrumentation-flakeflagger-$name-rerun $runs $runs   &> exp$exp.log

cp exp$exp.log $resultsdir/
