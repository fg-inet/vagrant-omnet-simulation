# Estimating Video Streaming QoE in the 5G Architecture Using Machine Learning - Simulation Environment

This is the simulation environment used in the paper:

Schwarzmann, S., Cassales Marquezan, C., Bosk, M., Liu, H., Trivisonno, R., & Zinner, T. (2019, October). Estimating Video Streaming QoE in the 5G Architecture Using Machine Learning. In <i>Proceedings of the 4th Internet-QoE Workshop on QoE-based Analysis and Management of Data Communication Networks</i> (pp. 7-12). ACM.

## Requirements
Vagrant - Tested with version 2.2.4 (available at: https://www.vagrantup.com/downloads.html)

## Setup
Using a terminal of your choice switch into the main directory of this repository. In this folder use: 
```bash
$ vagrant up
```
And wait until the vagrant box setup is complete. It may take some time.

## Using the Simulation Environment
To access the box and the simulation environment that was used within the project use the following command while remaining in the main folder of this repository:
```bash
$ vagrant ssh
```
This will establish an ssh connection to the box. In there you can access the simulation environment.

### Running a Simulation
In order to run simulation campaigns (as they were run within the project) switch to the `SimNetwork1/simulations` folder:
```bash
$ cd SimNetwork1/simulations
```
and use the following command to run an exemplary simulation campaign:
```bash
$ ./run_sim_campaign.sh -c testA_ds0 -t 4
```
This will run a simulation campaign with the name "testA_ds0" with up to 4 simulation runs running in parallel. You can adjust the -t argument based on the number of threads your system has.

-c argument specifies the campaign name.

### Available Simulation Campaigns
Currently there are four available simulation campaigns which differ only in the random number generation seed used:
* testA_ds0 - seed: 5
* testA_ds1 - seed: 41326
* testA_ds2 - seed: 6780123
* testA_ds3 - seed: 510959834

Each simulation campaign consists of 10 simulation runs which differ in the number of active clients.

Other common settings used in all of the above simulation campaigns:
* Number of user equipment devices varied between simulation runs within the campaign beginning at 20 and increasing by 20 in each consequent run until 200 clients
* The user equipment devices are placed within a 500m by 500m square surrounding the antenna tower.
* Video bitrate settings (various qualities available for the video client) - 500kbps, 1500kbps, 3000kbps
* Video duration - 300s
* Video segment length - 5s

### Adjusting the Simulation
The simulation can be easily manipulated and adjusted in the omnetpp.ini file that can be found in `resources/SimNetwork1/simulations` folder. NOTE: If you want to adjust the file and run a simulation with it, you need to adjust the file that is in the Vagrant Box at `~/SimNetwork1/simulations`. 

## Used Software
The following software has been used to set up the simulation environment:
* Omnet++ version 5.1 (https://gateway.ipfs.io/ipns/ipfs.omnetpp.org/release/5.1/omnetpp-5.1-src-linux.tgz)
* INET framework version 3.5.0 (https://github.com/inet-framework/inet/releases/download/v3.5.0/inet-3.5.0-src.tgz)
* SimuLTE framework version 0.9.1 (https://github.com/inet-framework/simulte/archive/v0.9.1.tar.gz)

### Software Modifications
To fulfil the requirements that the simulation environment had to fulfil, we needed to extend the INET framework with a TCP DASH video client which can be found in `resources/tcpVideoClient` folder. 
This extension has been made using an adaptation of the code of Navarro Joaquim (https://github.com/navarrojoaquin/adaptive-video-tcp-omnet) created on 8 December 2017 by Anderson Andrei da Silva & Patrick Menani Abrahão at University of São Paulo (Source: https://github.com/inet-framework/inet/tree/topic/tcpvideosteaming/src/inet/applications/tcpapp). This software was then edited and adapted for Omnet++ 5.1 with INET 3.5 by Marcin Bosk at the Technische Universitaet Berlin in January 2019.
