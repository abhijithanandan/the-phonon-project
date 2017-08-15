awk '/ITEM: ATOMS/,/ITEM: TIMESTEP/' velocity.dat > tmp.dat
sed -i '/ITEM/d' tmp.dat
mv tmp.dat vel.dat

sort -n -k1 vel.dat > velSorted.dat

awk 'NR%10001==0{print $1}' velSorted.dat > ids.dat

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

i=1
num=1
while [ ${num} ]; 
do
	cp ./vel$num.txt vel.tmp
	python vacf.py
	cp vacf.tmp vacf${num}.dat
	echo "written vacf$num"
	rm -f *.tmp	
	num=$(sed "${i}q;d" ids.dat)
	i=$(($i+1))
done

paste -d" " vacf{1..1000}.dat > vacf_combined1.tmp 
paste -d" " vacf{1001..2000}.dat > vacf_combined2.tmp 
paste -d" " vacf{2001..3000}.dat > vacf_combined3.tmp 
paste -d" " vacf{3001..3936}.dat > vacf_combined4.tmp 
awk '{tot=0;avg=0;}{for(i=1;i<=NF;i++){tot+=$i;}avg=tot/NF;printf "%.30f\n",avg;}' vacf_combined1.tmp > vacf_avg1.dat
awk '{tot=0;avg=0;}{for(i=1;i<=NF;i++){tot+=$i;}avg=tot/NF;printf "%.30f\n",avg;}' vacf_combined2.tmp > vacf_avg2.dat
awk '{tot=0;avg=0;}{for(i=1;i<=NF;i++){tot+=$i;}avg=tot/NF;printf "%.30f\n",avg;}' vacf_combined3.tmp > vacf_avg3.dat
awk '{tot=0;avg=0;}{for(i=1;i<=NF;i++){tot+=$i;}avg=tot/NF;printf "%.30f\n",avg;}' vacf_combined4.tmp > vacf_avg4.dat
paste -d" " vacf_avg* > vacf_avg.tmp
awk '{tot=0;avg=0;}{for(i=1;i<=NF;i++){tot+=$i;}avg=tot/NF;printf "%.30f\n",avg;}' vacf_avg.tmp > vacf_avg.dat
paste vacf_avg.dat > vacf.dat
