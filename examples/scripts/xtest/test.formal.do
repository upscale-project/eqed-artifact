onerror {exit 1}
do ccx.formal_directives.do
configure error -inferred black_box
formal compile -d ccx
###formal verify -init ccx.init.seq
exit 0
