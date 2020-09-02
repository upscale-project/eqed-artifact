#!/bin/sh

qformal -c -od Output_Results -do "\
    do directives.tcl; \
    formal compile -d l2c_wrapper_2  -cuname l2c_checker2 -target_cover_statements; \
    exit"

