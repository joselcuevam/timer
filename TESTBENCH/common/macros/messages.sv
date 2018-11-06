
`define SHOWM(info_message)      \
  $display(                          \
  `"[%m]  : %s`",`"info_message`",    \
  `" T=%0d`",$stime)     

`define SHOWM_VALUE(info_message,value)  \
  $display(                          \
  `"[%m]  : %s`",`"info_message`",    \
  `" =%0h`",value,   \
  `" T=%0d`",$stime)     
   
`define SHOW(info_message)      \
  $display(                          \
  `"  : %s`",`"info_message`",    \
  `" T=%0d`",$stime) 
