#!/bin/env bash
set -e
green="\e[0;92m"
red="\e[0;91m"
reset="\e[0m"
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	echo -e "${red}-I- Not running as root, exit${reset}"
    exit
fi
SYSTEMC_VERSION=${SYSTEMC_VERSION:-systemc-2.3.2}
INSTALL_PREFIX=${INSTALL_PREFIX:-/opt/${SYSTEMC_VERSION}}
NPROC=$(nproc)
echo -e "${green}-I- Installing SystemC${reset}"
wget https://accellera.org/images/downloads/standards/systemc/${SYSTEMC_VERSION}.zip
unzip -q ${SYSTEMC_VERSION}
cd ${SYSTEMC_VERSION}
mkdir build
cd build
sudo mkdir ${INSTALL_PREFIX}
../configure --prefix=${INSTALL_PREFIX} CXXFLAGS="-DSC_CPLUSPLUS=201103L"
# assuming we want clang
# ../configure --prefix=${INSTALL_PREFIX} CXXFLAGS="-DSC_CPLUSPLUS=201103L" CC=clang CXX=clang++
make -j$NPROC
sudo make install
echo -e "${green}-I- Installed SystemC, cleaning up${reset}"
cd ../../
sudo rm -rf ${SYSTEMC_VERSION}.zip ${SYSTEMC_VERSION}
echo -e "${green}-I- Done${reset}"
echo -e "${green}-I- exporting SYSTEMC_HOME to zshrc${reset}"
EXPORT_STRING="export SYSTEMC_HOME=${INSTALL_PREFIX}"
echo $EXPORT_STRING >>~/.zshrc
EXPORT_STRING2="export LD_LIBRARY_PATH=${INSTALL_PREFIX}/lib-linux64:\$LD_LIBRARY_PATH" #untested
echo $EXPORT_STRING2 >>~/.zshrc #untested
echo -e "${green}-I- exported SYSTEMC_HOME to zshrc${reset}"
