awk  'NR>=24 && NR<=3024 {print $0}' thermo.log > thermo.dat 
awk  'NR>=3072 && NR<=6072 {print $0}' thermo.log >> thermo.dat 
awk  'NR>6114 && NR<=6614 {print $0}' thermo.log >> thermo.dat 
awk  'NR>6663 && NR<=7663 {print $0}' thermo.log >> thermo.dat 
