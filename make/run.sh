#!/bin/env bash
##
echo " Initialize "
##

##############################################################

#set environmente vars

PROJ="$HOME/timer_test/timer"

# initialize vars

caf_file="$PROJ/work/caf"

#create files and folder
rm -rf work
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
    echo "run simulation"
    eval irun -access +rw -f $caf_file -input ../tool_data/simvision/run.tcl
  ;; 
"-w")
    echo "open simulation waveform"
    eval simvision $PROJ/work/timer.shm -input $PROJ/tool_data/simvision/simvision.svcf
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
 action $var
done
