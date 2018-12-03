#!/usr/bin/env bash
#remove existent iverilog installations
yes|sudo apt-get purge iverilog
yes|sudo apt-get install flex
yes|sudo apt-get install gcc
yes|sudo apt-get install bison
yes|sudo apt-get install g++
yes|sudo apt-get install autoconf
yes|sudo apt-get install gperf

mkdir -p $HOME/git_folder
cd $HOME/git_folder
git clone https://github.com/steveicarus/iverilog
cd iverilog/
autoconf
./configure
sudo make
sudo make install
##done
