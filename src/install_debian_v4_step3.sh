#!/bin/bash
# :se ff=unix
# :se background=dark

# https://techviewleo.com/how-to-install-python-on-amazon-linux-2/

#
# check for local bin in the path
#
PAT="^\/ome\/$USER\/bin:"

if [[ ! $PATH =~ $PAT ]]; then
    echo "/home/$USER/bin missing from path...";
    echo "Path should be: /home/$USER/bin:/usr.....";
    echo "Path is       : $PATH";
    exit
fi


# this packages are required to build a python that is suitable for SD
sudo apt install -y libffi-dev libssl-dev liblzma-dev libbz2-dev libncurses5-dev libsqlite3-dev libreadline-dev libtk8.6 libgdm-dev libdb4o-cil-dev libpcap-dev


# install python 3.10.6
VER=3.10
VERS=$VER.6

wget https://www.python.org/ftp/python/$VERS/Python-$VERS.tgz
tar -xf Python-$VERS.tgz
cd Python-$VERS/
./configure --enable-optimizations
make -j 3 # build on 3 cores
cd ..
rm Python-$VERS.tgz

# make our python the python3 for this account
ln -s ~/Python-$VERS/python ~/bin/python3
echo "This should now say Python $VERS --> " `python3 --version`

