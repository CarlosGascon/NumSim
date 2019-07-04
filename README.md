In order to run the numerical simulations in Linux, the following previous 
steps should be followed:

1. Clone the NumSim repository: git clone https://github.com/CarlosGascon/NumSim.git
2. Clone the REBOUND repository: git clone https://github.com/hannorein/rebound.git
3. Enter REBOUND directory: cd rebound 
4. Compile REBOUND: make
5. Exit REBOUND directory: cd ..
6. Create symbolic link: 	ln -s ./rebound/librebound.so ./NumSim/librebound.so
7. Export library Path: export LD_LIBRARY_PATH=`pwd`'/rebound/src'
8. Enter NumSim directory: cd NumSim
9. Run matlab from same terminal: matlab &
10. Generate Matlab executable file by running GenerateMex.m
11. Configure simulation parameters and run Main.m
