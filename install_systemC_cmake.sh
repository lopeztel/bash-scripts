#!/bin/env bash
set -e
green="\e[0;92m"
red="\e[0;91m"
reset="\e[0m"

AS_SUDO="false"
SIMPLE_CURSES="false"
NPROC=$(nproc)

# check for simple curses installation
# if [[ -f /usr/local/lib/simple_curses.sh ]]; then
    #import bashsimplecurses
    # source /usr/local/lib/simple_curses.sh
    # SIMPLE_CURSES="true"
# else
    # exit
# fi

while [[ 1 ]]; do
echo -e "Which SystemC version to download:"
echo -e "  (1) 2.3.1"
echo -e "  (2) 2.3.2"
echo -e "  (3) 2.3.3"
read choice

    if [[ $choice == 1 ]]; then
        SYSTEMC_VERSION=${SYSTEMC_VERSION:-systemc-2.3.1a}
        break
    elif [[ $choice == 2 ]]; then
        SYSTEMC_VERSION=${SYSTEMC_VERSION:-systemc-2.3.2}
        break
    elif [[ $choice == 3 ]]; then
        SYSTEMC_VERSION=${SYSTEMC_VERSION:-systemc-2.3.3}
        break
    else
        echo -e "Wrong choice, try again"
    fi
done

# check sudo status
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    INSTALL_PREFIX=${INSTALL_PREFIX:-~/.local/${SYSTEMC_VERSION}}
    echo -e "${green}-I- Not running as root, installing SystemC to: ${INSTALL_PREFIX} ${reset}"
    # exit
else
    INSTALL_PREFIX=${INSTALL_PREFIX:-/opt/${SYSTEMC_VERSION}}
    echo -e "${green}-I- Running as root, installing SystemC to: ${INSTALL_PREFIX} ${reset}"
    AS_SUDO="true"
fi


echo -e "${green}-I- Chosen version: ${SYSTEMC_VERSION}, downloading...${reset}"
wget https://accellera.org/images/downloads/standards/systemc/${SYSTEMC_VERSION}.zip
unzip -q ${SYSTEMC_VERSION}
cd ${SYSTEMC_VERSION}
mkdir build && cd build
cmake ../ -DINSTALL_TO_LIB_TARGET_ARCH_DIR=ON -DCMAKE_CXX_STANDARD=11 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}
make -j$NPROC
make check -j$NPROC
if [ $? -ne 0 ]; then
    echo -e "${red}-E- Something went wrong with the check, exit${reset}"
    exit 1
fi
make install

echo -e "${green}-I- Installed SystemC, cleaning up${reset}"
cd ../../
rm -rf ${SYSTEMC_VERSION}.zip ${SYSTEMC_VERSION}

while [[ 1 ]]; do
    echo -e "Install CCI?"
    echo -e "  (1) yes"
    echo -e "  (2) no"
    read choice

    if [[ $choice == 1 ]]; then
        # check sudo status
        if [[ $AS_SUDO == "false" ]]; then
            RAPID_JSON_INSTALL_PREFIX=${RAPID_JSON_INSTALL_PREFIX:-~/.local/rapidjson}
            echo -e "${green}-I- Not running as root, installing rapidJSON to: ${RAPID_JSON_INSTALL_PREFIX} ${reset}"
        elif [[ $AS_SUDO == "true" ]]; then
            RAPID_JSON_INSTALL_PREFIX=${RAPID_JSON_INSTALL_PREFIX:-/opt/rapidjson}
            echo -e "${green}-I- Running as root, installing rapidJSON to: ${RAPID_JSON_INSTALL_PREFIX} ${reset}"
        fi
        echo -e "${green}-I- Cloning RapidJSON...${reset}"
        git clone https://github.com/Tencent/rapidjson.git
        cd rapidjson
        mkdir build && cd build
        cmake ../ -DCMAKE_CXX_STANDARD=11 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${RAPID_JSON_INSTALL_PREFIX}
        make -j$NPROC
        if [ $? -ne 0 ]; then
            echo -e "${red} Something went wrong with the make, exit${reset}"
            exit 1
        fi
        make install
        echo -e "${green}-I- Installed rapidJSON, cleaning up${reset}"
        cd ../../
        rm -rf rapidjson
        echo -e "${green}-I- Cloning CCI...${reset}"
        git clone https://github.com/accellera-official/cci.git
        cd cci
        mkdir build && cd build
        cmake ../ -DINSTALL_TO_LIB_TARGET_ARCH_DIR=ON -DCMAKE_CXX_STANDARD=11 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DRapidJSON_DIR=${RAPID_JSON_INSTALL_PREFIX}/lib/cmake/RapidJSON
        make -j$NPROC
        make check -j$NPROC
        if [ $? -neq 0]; then
            echo -e "${red} Something went wrong with the check, exit${reset}"
            exit 1
        fi
        make install
        echo -e "${green}-I- Installed SystemC CCI, cleaning up${reset}"
        cd ../../
        rm -rf cci
        echo -e "${green}-I- CCI installed${reset}"
        break
    elif [[ $choice == 2 ]]; then
        echo -e "${green}-I- CCI not installed${reset}"
        break
    else
        echo -e "Wrong choice, try again"
    fi
done
echo -e "${green}-I- Done${reset}"

while [[ 1 ]]; do
    echo -e "Install AMS?"
    echo -e "  (1) yes"
    echo -e "  (2) no"
    read choice

    if [[ $choice == 1 ]]; then
        wget https://www.coseda-tech.com/files/Files/Proof-of-Concepts/systemc-ams-2.3.tar.gz
        tar -xvzf systemc-ams-2.3.tar.gz
        cd systemc-ams-2.3
        mkdir build && cd build
        ../configure CXXFLAGS="-DSC_CPLUSPLUS=201103L" --with-systemc=${INSTALL_PREFIX} --prefix=${INSTALL_PREFIX} --with-arch-suffix --disable-systemc_compile_check
        make -j$NPROC
        if [ $? -ne 0 ]; then
            echo -e "${red} Something went wrong with the make, exit${reset}"
            exit 1
        fi
        make install
        echo -e "${green}-I- Installed AMS, cleaning up${reset}"
        cd ../../
        rm -rf systemc-ams-2.3.tar.gz systemc-ams-2.3
    elif [[ $choice == 2 ]]; then
        echo -e "${green}-I- AMS not installed${reset}"
        break
    else
        echo -e "Wrong choice, try again"
    fi
done
echo -e "${green}-I- Done${reset}"
