
make -f Makefile
vsim -L unisim -t 10fs work.main -voptargs="+acc"

radix -hexadecimal


do wave.do

run 300us
#wave zoomfull

