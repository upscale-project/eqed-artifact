#!/bin/sh

qformal -c -od Output_Results -do "\
    formal load db Output_Results/formal_compile.db; \
    formal verify -init test.init -rtl_init_values -effort unlimited -timeout 24h; \
    exit"

