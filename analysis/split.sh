awk '/ITEM: ATOMS/,/ITEM: TIMESTEP/' velocity.dat > tmp.dat
sed -i '/ITEM/d' tmp.dat
mv tmp.dat vel.dat

sort -n -k1 vel.dat > velSorted.dat

awk 'NR%10000==0{print $1}' velSorted.dat > ids.dat

i=1
num=1
while [ ${num} ]; 
do
	awk '$1=='${num}'{print $0}' velSorted.dat > velxyz.tmp
	awk '{r=($2*$2+$3*$3+$4*$4)**0.5;}{printf"%d %0.20f %0.20f %0.20f %0.20f\n",$1,$2,$3,$4,r;}' velxyz.tmp > vel.tmp
	cp vel.tmp vel${num}.txt
	echo done $num 
	rm -f *.tmp	
	num=$(sed "${i}q;d" ids.dat)
	i=$(($i+1))
done

