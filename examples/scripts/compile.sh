#!/bin/sh

qformal -c -od Output_Results -do "\
    do directives.tcl; \
    formal compile -d spc_wrapper  -cuname spc_checker_bind -target_cover_statements; \
    exit"

