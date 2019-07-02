# Vagrant box for simulation with Omnet++ and SimuLTE

A readme for vagrant box with Omnet++ simulation setup for "Machine Learning Integration in 5G Systems for QoE Estimation" project.

## Requirements
Vagrant - Tested with version 2.2.4 (available at: https://www.vagrantup.com/downloads.html)

## Vagrant box setup
In the `\vagrant-omnet-simulation` folder use: 
```bash
$ vagrant up
```

And wait until the vagrant box setup is complete.

## Using the Omnet++ simulator

To access the box and the simulation environment use the following command while remaining in the `\vagrant-omnet-simulation` folder:

```bash
$ vagrant ssh
```

This will establish an ssh connection to the box. In there you can access the simulation environment.

### Running a simulation

In order to run simulation campaigns (as they were run within the project) switch to the `SimNetwork1/simulations` folder:

```bash
$ cd SimNetwork1/simulations
```

and use the following command to run an exemplary simulation campaign:

```bash
$ ./run_sim_campaign.sh -c testA_ds0 -t 4
```

This will run a simulation campaign with the name "testA_ds0" with up to 4 simulation runs running in parallel. You can adjust the -t argument based on the number of threads your system has.

-c argument specifies the campaign name. Currently there are four available simulation campaigns:
* testA_ds0
* testA_ds1
* testA_ds2
* testA_ds3
