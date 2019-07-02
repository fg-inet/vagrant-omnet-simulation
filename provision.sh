#!/usr/bin/env bash

sudo apt-get upgrade
sudo apt-get update
echo "#### Install software-properties-common ####"
sudo apt-get install -y software-properties-common
echo "#### Add repository ppa:ubuntu-toolchain-r/test ####"
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
echo "#### Install other packages ####"
sudo apt-get install -y xauth build-essential gcc-5 g++-5 bison flex perl tcl-dev tk-dev blt libxml2-dev zlib1g-dev openjdk-6-jre doxygen graphviz openmpi-bin libopenmpi-dev libpcap-dev
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 --slave /usr/bin/g++ g++ /usr/bin/g++-5
echo "#### Downloading Omnet++ version 5.1 ####"
echo "#### will try downloading up to 10 times with 10s timeouts between retries ####"
wget -c --tries=10 --read-timeout=10 --progress=bar:force https://gateway.ipfs.io/ipns/ipfs.omnetpp.org/release/5.1/omnetpp-5.1-src-linux.tgz
tar xvfz omnetpp-5.1-src-linux.tgz &> /dev/null
if [ -d "omnetpp-5.1" ]; then
  echo "#### Omnet++ successfully downloaded ####"
  cd omnetpp-5.1
  echo "#### Compiling and installing Omnet++ version 5.1 ####"
  ./configure WITH_TKENV=no WITH_QTENV=no WITH_OSG=no NO_TCL=yes WITH_OSGEARTH=no
  make
  cd ~
  echo "#### Download and extract INET version 3.5.0 ####"
  wget --progress=bar:force https://github.com/inet-framework/inet/releases/download/v3.5.0/inet-3.5.0-src.tgz
  tar xvfz inet-3.5.0-src.tgz &> /dev/null
  mv inet omnetpp-5.1/samples/
  echo "#### Download and extract SimuLTE version 0.9.1 ####"
  wget --progress=bar:force https://github.com/inet-framework/simulte/archive/v0.9.1.tar.gz
  tar xvfz v0.9.1.tar.gz &> /dev/null
  mv simulte-0.9.1 omnetpp-5.1/samples/
  echo "#### Copy the TCP Video Client to INET TCP applications folder ####"
  cp -a resources/tcpVideoClient/. omnetpp-5.1/samples/inet/src/inet/applications/tcpapp/
  rm -rf inet-3.5.0-src.tgz
  rm -rf omnetpp-5.1-src-linux.tgz
  rm -rf v0.9.1.tar.gz
  cd omnetpp-5.1/samples/inet
  echo "#### Compile INET ####"
  make makefiles
  make
  echo "#### Compile SimuLTE ####"
  cd ../simulte-0.9.1
  make makefiles
  make
  echo "Preparing the simulation network"
  cd ~
  cp -r resources/SimNetwork1 .
  echo "#### Simulation environment setup should be complete - assuming there were no errors (this script does not do thorough checks yet) ####"
else
  echo "#### Omnet++ downloaded unsuccessful - setup was not successful ####"
fi