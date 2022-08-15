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

if ! grep -q "# tools_install_gui.sh done." $INSTALL_LOG; then

  sudo apt install -y lm-sensors curl python3 python3-pip matchbox-keyboard unclutter
  pip3 install --upgrade pip

  sudo raspi-config nonint do_vnc 0
  sudo raspi-config nonint do_vnc_resolution 1920x1080
  sudo raspi-config nonint do_blanking 1
  sudo raspi-config nonint do_boot_behaviour B4
  sudo raspi-config nonint do_boot_splash 0
  sudo raspi-config nonint do_boot_wait 0
  sudo raspi-config nonint do_spi 1
  sudo raspi-config nonint do_i2c 0
  sudo raspi-config nonint do_serial 2
  sudo raspi-config nonint do_wifi_country de

    if ! grep -q "# Touchscreen config" /boot/config.txt; then
      echo '# Touchscreen config' | sudo tee -a /boot/config.txt
      echo 'lcd_rotate=2' | sudo tee -a /boot/config.txt
      echo 'disable_splash=1' | sudo tee -a /boot/config.txt
      sudo sed -i 's/dtoverlay=vc4-kms-v3d/#dtoverlay=vc4-kms-v3d/' /boot/config.txt
      sudo cp -f setup_common/files/splash/splash_480.png /usr/share/plymouth/themes/pix/splash.png
      echo 'xserver-command = X -nocursor' | sudo tee -a /etc/lightdm/lightdm.conf
      sudo sed -i -e 's/$/ logo.nologo consoleblank=0 loglevel=1 quiet vt.global_cursor_default=0 fastboot noswap/' /boot/cmdline.txt
    fi

    echo '# tools_install_gui.sh done.' | sudo tee -a $INSTALL_LOG
fi

