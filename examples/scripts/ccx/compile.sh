#!/bin/sh

qformal -c -od Output_Results -do "\
    do directives.tcl; \
    formal compile -d ccx_wrapper  -target_cover_statements; \
    exit"

