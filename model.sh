#/bin/bash

WD="$(pwd)"
WD="${WD}/"
cd ${WD}
mkdir MAPS
WD="${WD}MAPS/"
model=$1
domain=1
echo $1

if [ $1 == GFS ]; then	
	nstep=3
	hour_int=( 00 06 12 18 )

elif [ $1 == ECM ]; then
	model=ECM
	nstep=24 #step of charts
        hour_int=( 00 12 )
fi
nfinal=144

cd ${WD}
rm -r ${model}
mkdir ${model}
cd ${model}

##################### END USER #################
for time in "${hour_int[@]}";
	do
        echo ${time}
	mkdir ${time}

	cd "${WD}${model}/${time}"

	for hour in `seq 0 ${nstep} ${nfinal}`
		do    
  		echo "Downloading hour..."$hour 
		url="www.wetterzentrale.de/maps/${model}OPEU${time}_${hour}_${domain}.png"
		echo ${url}
		wget ${url}
	done
	cd "${WD}${model}/"
done

cd "${WD}
