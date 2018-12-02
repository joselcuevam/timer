#!/bin/env bash
##
echo " Initialize "
##
TIMER_CONF="$HOME/.timer_conf"
##############################################################

#set environmente vars

PROJ="$HOME/timer_test/timer"

# initialize vars

caf_file="$PROJ/work/caf"
stim_name="free_run"

if [ -f $TIMER_CONF ]; then
  source $TIMER_CONF
else
  echo "missing configuration file $TIMER_CONF"  
fi
  

##############################################################

#create files and folder
#rm -rf work
mkdir -p $PROJ/work
cd $PROJ/work

##############################################################

function action() {
case $1 in
"-e")
  Message="Edit run script"
  (nedit "$PROJ/make/run.sh" &)
  ;;
"-clean")
  rm -rf work
  ;;  
"-c")
    echo "generate caf file containing modules of design"
    echo ""
    echo "caf:$caf_file"
    echo "..remove caf"
    rm   $caf_file -rf
    echo "..goto work folder"
    cd   $PROJ
    echo "..get rtl & testbench files"
    find `pwd` -type f -name '*.sv' |grep -v vectorset|grep -v tasks|sort> $caf_file
    cd   -
    echo "caf file content:"
    cat  $caf_file
    echo ""
  ;;
"-r")
    stim_name=$2
    echo "stimulus name: $stim_name"
    unlink $PROJ/TESTBENCH/vectorset/test.sv
    ln -s $PROJ/TESTBENCH/vectorset/$stim_name".sv" $PROJ/TESTBENCH/vectorset/test.sv
    echo "run simulation"
    comando="irun -access +rw -incdir $PROJ/TESTBENCH/tasks -f $caf_file -top tb_counter -input ../tool_data/simvision/run.tcl "
    echo $comando
    eval $comando
  ;; 
"-w")
    echo "open simulation waveform"
    comando="simvision $PROJ/work/timer.shm -input $PROJ/tool_data/simvision/simvision.svcf"
    echo $comando
    eval $comando
  ;; 
"-n")
    echo "open files"
    nedit $PROJ/RTL/* $PROJ/TESTBENCH/*.sv $PROJ/TESTBENCH/*/*.sv $PROJ/make/run.sh
  ;;
*)
  Message="Command not found"
  ;;
esac
echo $Message

}

##############################################################



#check arguments

for var in "$@"
do
 action $var $2
 
done

