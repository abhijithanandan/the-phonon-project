package require nanotube
package require topotools

set molname graphene

graphene -lx 10 -ly 10 -type zigzag -b 0
set sel [atomselect top all]
$sel moveby {0.7090 0.0 0.0}
$sel writepdb $molname.pdb
$sel writepsf $molname.psf
topo writelammpsdata $molname.lmpsys

set mm [measure minmax $sel]
set xlo [format %.4f [expr [lindex $mm 0 0]+0.0] ]
set xhi [format %.4f [expr [lindex $mm 1 0]+1.4200] ]; # very imp
set ylo [format %.4f [expr [lindex $mm 0 1]+0.0] ]
set yhi [format %.4f [expr [lindex $mm 1 1]+1.2298] ]; # very imp
set zlo [format %.4f [expr [lindex $mm 0 2]-1.0] ]
set zhi [format %.4f [expr [lindex $mm 1 2]+1.0] ]

exec sed -i "12s/.*/  $xlo $xhi  xlo xhi/" $molname.lmpsys
exec sed -i "13s/.*/  $ylo $yhi  ylo yhi/" $molname.lmpsys
exec sed -i "14s/.*/  $zlo $zhi  zlo zhi/" $molname.lmpsys

exec rm -f $molname.pdb
mol delete all
exit
