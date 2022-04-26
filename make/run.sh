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
PROJ="$HOME/timer"
VVP_LIB="$HOME/apps/lib/ivl"

stim_name="free_run"

if [ -f $TIMER_CONF ]; then
  source $TIMER_CONF
  echo "sourced configuration file"
  echo "\$PROJ:$PROJ"
else
  echo "missing configuration file $TIMER_CONF"  
fi

# initialize vars

caf_file="$PROJ/work/caf"
caf_file_iverilog="$PROJ/work/caf_iverilog"


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
    rm   $caf_file $caf_file_iverilog -rf
    echo "..goto work folder"
    cd   $PROJ
    echo "..get rtl & testbench files"
    find -L `pwd` -type f -name '*.sv' |grep -v vectorset|grep -v tasks|sort> $caf_file
    cd   -
    echo "caf file content:"
    cat  $caf_file
    echo "+incdir+$PROJ/TESTBENCH/tasks" > $caf_file_iverilog
    cat $caf_file >> $caf_file_iverilog
    echo ""
    
  ;;
"-r")
    stim_name=$2
    echo "stimulus name: $stim_name"
    unlink $PROJ/TESTBENCH/vectorset/test.sv
    ln -s $PROJ/TESTBENCH/vectorset/$stim_name".sv" $PROJ/TESTBENCH/vectorset/test.sv
    echo "run simulation"
    command="irun -access +rw -incdir $PROJ/TESTBENCH/tasks -f $caf_file -top tb_counter -input ../tool_data/simvision/run.tcl "
    echo $command
    eval $command
  ;;
"-ri")
    stim_name=$2
    echo "stimulus name: $stim_name"
    unlink $PROJ/TESTBENCH/vectorset/test.sv
    ln -s $PROJ/TESTBENCH/vectorset/$stim_name".sv" $PROJ/TESTBENCH/vectorset/test.sv
    echo "run simulation"
    command="iverilog -c $caf_file_iverilog -o timer.vvp;vvp -M $VVP_LIB timer.vvp"
    echo $command
    eval $command
  ;;   
   
"-w")
    echo "open simulation waveform"
    command="simvision $PROJ/work/timer.shm -input $PROJ/tool_data/simvision/simvision.svcf"
    echo $command
    eval $command
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

