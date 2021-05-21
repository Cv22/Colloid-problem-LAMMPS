#!/bin/bash



module load gcc/9.2.0
module load mpi/openmpi4-x86_64
mkdir lj
for SOLVENT in 0.96 0.92 0.8 0.7;
do
	cd lj
	mkdir col_$SOLVENT
	cd col_$SOLVENT
	touch rdf.txt
	cp ~/colloid/colloid/in.colloid ~/colloid/lj/col_$SOLVENT
	sed "s/YYYYFFFF/$SOLVENT/g" in.colloid > in.colloid2
	srun -N 1 --ntasks-per-node=1 -J lammps_sidorenko --comment="lammps melting" -p RT ~/bin/lmp_mpi -in in.colloid2
	cd ../../
	#sum=$(awk -f awk.sh lj/temp_$TEMP/log.lammps)
	#echo "$TEMP $sum" >> Temp.txt
	cd lj/col_$SOLVENT/
	rdf=$(tail -n50 ~/colloid/lj/col_$SOLVENT/tmp.rdf)
	echo "$rdf" >> rdf.txt
	cd ../../
done
gnuplot graph.sh
curl -s -X POST https://api.telegram.org/bot1656388332:AAHTq04eCbpsmwHwWpMi2gazwUom_bqRWtA/sendPhoto -F chat_id=514937609 -F photo="RDF.png" -F caption="Calculations are ready"
curl -s -X POST https://api.telegram.org/bot1656388332:AAHTq04eCbpsmwHwWpMi2gazwUom_bqRWtA/sendMessage -d chat_id=514937609 -d text="Calculations are ready"
