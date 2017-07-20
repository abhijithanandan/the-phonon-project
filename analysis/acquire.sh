awk  'NR>=29 && NR<=1029 {print $0}' thermo.log > thermo.dat 
awk  'NR>=1071 && NR<=1570 {print $0}' thermo.log >> thermo.dat 
awk  'NR>=1620 && NR<=2620 {print $0}' thermo.log >> thermo.dat 
