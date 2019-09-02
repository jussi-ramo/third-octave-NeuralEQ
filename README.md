# Neural Third-Octave Graphic Equalizer
This repository has the Matlab scripts needed to run the the Neural Third-Octave Graphic Equalizer (NGEQ3), introduced in the Proceedings of DAFx-19 conference by Jussi Rämö and Vesa Välimäki.

## Instructions for the Matlab Scripts
The Matlab scripts for the neural third-order graphic equalizers can be found in the folder NGEQ3scripts. The folder includes the following files:
    * GEQfilter3.m
    * NGEQ3_MatlabNetworkObj.mat
    * NGEQ3_parameters.mat
    * NGEQ3.m 
    * NGEQfilterAudio3.m
    * pareq2.m
    * plotNGEQ3.m

### Run the example
To run an example design of the third-octave graphic equalizer, run the file __plotNGEQ3__, which designs and plots the EQ with given user-set target gains (zig zag by default).

The script uses __NGEQ3__, which loads the neural net parameters (__NGEQ3_parameters__), to run the filter optimization calculation. Then the __GEQfilter3__ takes these optimized filter gains and designs the needed equalization band filters using __pareq2__.

### Other matlab files
__NGEQ3_MatlabNetworkObj__ includes Matlab's net object that has all the required information for Matlab to run the neural network. To use the net object, just give the object the user-set target gains and it outputs the optimized filter gains, e.g., filterGains = net(12*ones(31,1)).

__NGEQfilterAudio3.m__ can be used to filter audio by giving it the input audio sample and the user-set target gains.
