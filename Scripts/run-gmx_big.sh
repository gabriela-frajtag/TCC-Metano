#!/bin/sh
#SBATCH --job-name=gromacs
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --time=5-00:00:00
#SBATCH --output=out.log
#SBATCH --partition=short-gpu-big

lst=$1
testing=$2

#echo quit | nvidia-cuda-mps-control
export GMX_FORCE_UPDATE_DEFAULT_GPU=true

pin='off'
where=$(pwd)

for path_prefix in $lst ; do
	path=$(echo $path_prefix | awk 'BEGIN{OFS="/";FS="/"}{NF--; print}')
	prefix=$(echo $path_prefix | awk 'BEGIN{OFS="/";FS="/"}{print $NF}')

	if [ "$path" == "" ]; then path="."; fi

	echo $path_prefix
	echo $path
	echo $prefix

	cd $path
 	if [ ! -e "$prefix"'.gro' ]; then
		str='-s '"$prefix"'.tpr -v -deffnm '"$prefix"' -pin '"$pin"' -nstlist 150 -nb gpu -bonded gpu -pme gpu -ntomp '"$SLURM_CPUS_PER_TASK"
 		if [ -e "$prefix"'.xtc' ]; then str="$str"' -cpi '"$prefix"'.cpt -append'  ; fi
 		if [ ! -z "$testing" ]; then str="$str"' -nsteps 50000 -resetstep 40000 -noconfout' ; echo ''; echo 'testando'; echo ''; fi
 		echo -e "\t\t""$str"
  		singularity run --nv ~/gromacs_2024.5_gpu.sif mdrun $str &
       	fi

	cd $where
done
wait

