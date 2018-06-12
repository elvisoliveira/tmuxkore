#!/bin/bash
declare -a functions=($(ls ./profiles))
for((i=0;i<${#functions[@]};i++)); do
    echo "[$i] ${functions[i]}"
done