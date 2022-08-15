#!/bin/bash

#MIT License
#
#Copyright (c) 2022 aXe
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.


if ! grep -q "# gpsd_install.sh done." $INSTALL_LOG; then
    sudo apt install -y asciidoctor pps-tools ncurses-base python3-matplotlib gnuplot chrony gpsd gpsd-clients pps-tools libcap-dev
    pip3 install pyserial
    sudo cp -rf setup_common/files/gpsd/gpsd /etc/default/gpsd
    
    echo '# gpsd_install.sh done.' | sudo tee -a $INSTALL_LOG
fi

