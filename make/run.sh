#!/usr/bin/env bash
##############################################################
#
# Comments:
#
# on erros like ./run.sh: line 1: $'\r': command not found
# use dos2unix run.sh for fix
#
##############################################################

echo " Initialize "
##
TIMER_CONF="$HOME/.timer_conf"
##############################################################
#set environmente vars
TIMER_PROJ="$HOME/timer"
VVP_LIB="$HOME/apps/lib/ivl"

stim_name="free_run"

if [ -f $TIMER_CONF ]; then
  source $TIMER_CONF
  echo "sourced configuration file"
  echo "\$TIMER_PROJ:$TIMER_PROJ"
else
  echo "missing configuration file $TIMER_CONF"  
fi

# initialize vars

caf_file="$TIMER_PROJ/work/caf"
caf_file_iverilog="$TIMER_PROJ/work/caf_iverilog"


##############################################################

#create files and folder
#rm -rf work
mkdir -p $TIMER_PROJ/work
cd $TIMER_PROJ/work

##############################################################

function action() {
case $1 in
"-e")
  Message="Edit run script"
  (nedit "$TIMER_PROJ/make/run.sh" &)
  ;;
"-clean")
  rm -rf work
  ;;  
"-c")
    echo "generate caf file containing modules of design"
    echo ""
    echo "caf:$caf_file"
    echo "..remove caf"
    rm   $caf_file $caf_file_iverilog -rf
    echo "..goto work folder"
    cd   $TIMER_PROJ
    echo "..get rtl & testbench files"
    find -L `pwd` -type f -name '*.sv' |grep -v vectorset|grep -v tasks|sort> $caf_file
    cd   -
    echo "caf file content:"
    cat  $caf_file
    echo "+incdir+$TIMER_PROJ/TESTBENCH/tasks" > $caf_file_iverilog
    cat $caf_file >> $caf_file_iverilog
    echo ""
    
  ;;
"-r")
    stim_name=$2
    echo "stimulus name: $stim_name"
    unlink $TIMER_PROJ/TESTBENCH/vectorset/test.sv
    ln -s $TIMER_PROJ/TESTBENCH/vectorset/$stim_name".sv" $TIMER_PROJ/TESTBENCH/vectorset/test.sv
    echo "run simulation"
    command="irun -access +rw -incdir $TIMER_PROJ/TESTBENCH/tasks -f $caf_file -top tb_counter -input ../tool_data/simvision/run.tcl "
    echo $command
    eval $command
  ;;
"-ri")
    stim_name=$2
    echo "stimulus name: $stim_name"
    unlink $TIMER_PROJ/TESTBENCH/vectorset/test.sv
    ln -s $TIMER_PROJ/TESTBENCH/vectorset/$stim_name".sv" $TIMER_PROJ/TESTBENCH/vectorset/test.sv
    echo "run simulation"
    command="iverilog -c $caf_file_iverilog -o timer.vvp;vvp -M $VVP_LIB timer.vvp"
    echo $command
    eval $command
  ;;   
   
"-w")
    echo "open simulation waveform"
    command="simvision $TIMER_PROJ/work/timer.shm -input $TIMER_PROJ/tool_data/simvision/simvision.svcf"
    echo $command
    eval $command
  ;; 
"-n")
    echo "open files"
    nedit $TIMER_PROJ/RTL/* $TIMER_PROJ/TESTBENCH/*.sv $TIMER_PROJ/TESTBENCH/*/*.sv $TIMER_PROJ/make/run.sh
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

