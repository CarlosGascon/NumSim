%This function creates the matlab executable file from the C file
%reboundmex.c. This script needs to be ran before performing any
%simulations. 'Rebound path' must be replaced by the path to the folder
%containing the REBOUND code. 

mex -v -I/'Rebound path'/rebound/src -L/'Rebound path'/rebound/src -lrebound reboundmex.c CFLAGS="\$CFLAGS -std=c99"
