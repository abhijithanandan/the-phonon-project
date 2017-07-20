i=1
num=1
while [ ${num} ]; 
do
	awk '$1=='${num}'{print $0}' velSorted.dat > vel.tmp
	python vacf.py
	cp vacf.tmp vacf${num}.dat
	echo written vacf$num
	rm -f *.tmp	
	num=$(sed "${i}q;d" ids.dat)
	i=$(($i+1))
done

paste -d" " vacf* > vacf_combined.tmp 
awk '{tot=0;avg=0;}{for(i=0;i<NF;i++){tot+=$i;}avg=tot/NF;printf "%.20f\n",avg;}' vacf_combined.tmp > vacf_avg.dat
paste vacf_avg.dat > vacf.dat
