#!/bin/sh

qformal -c -od Output_Results -do "\
    do directives.tcl; \
    formal compile -d small_example -target_cover_statements; \
    exit"

