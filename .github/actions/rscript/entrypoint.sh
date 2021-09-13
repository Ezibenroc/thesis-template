#! /usr/bin/env sh
set -e

if [ $# -ne 1 ] ; then
    echo "Syntax: $0 script.R"
    exit 1
fi

Rscript -e 'print(as.data.frame(installed.packages()[,c(3:4)]))'
Rscript $1
