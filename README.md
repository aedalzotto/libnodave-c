[![Build Status](https://travis-ci.org/aedalzotto/libnodave-c.svg?branch=master)](https://travis-ci.org/aedalzotto/libnodave-c)

# DISCLAIMER

**Do NOT connect to a PLC unless you are certain it is safe to do so. It is assumed that you are experienced in PLC programming/troubleshooting and that you know EXACTLY what you are doing. PLCs are used to control industrial processes, motors, steam valves, hydraulic presses, etc. You are ABSOLUTELY RESPONSIBLE for ensuring that no one is in danger of being injured or killed because you affected the operation of a running PLC.
This program comes with NO warranty. Use it at your own risk.**

Simatic, Simatic S5, Simatic S7, S7-200, S7-300, S7-400 are registered Trademarks of Siemens Aktiengesellschaft, Berlin und Muenchen.

# libnodave

Exchange data with Siemens PLCs using MPI,PPI adapters or Ethernet with CPx43 or Ethernet over IBH/MHJ-Netlink or Deltalogic's NetLink PRO. This repository provides a clean way to properly compile the libnodave for C language and install the library in your machine.

## Getting Started

Here are the instructions to compile, install and add libnodave to your project.

### Compiling

This will compile the shared libraries for both x86-64 and x86.
```
make dist
```

### Installing

This will install to /usr/local/libnodave-$(VERSION)/
```
sudo make install
```

### Adding to you project

First of all, add the libnodave folder, the include path and library path to your env. Remember to replace the $(VERSION) with the appropriate version string. It is recommended to add the following lines to ~/.bashrc or ~/.zshrc. You can do it by running
```
make zshrc
```
or
```
make bashrc
```
or even
```
export LIBNODAVE=/usr/local/libnodave-$(VERSION)
export CPATH=$CPATH:$LIBNODAVE/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LIBNODAVE/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LIBNODAVE/lib32
export LIBRARY_PATH=$LIBRARY_PATH:$LIBNODAVE/lib32
export LIBRARY_PATH=$LIBRARY_PATH:$LIBNODAVE/lib
```

To compile your project with libnodave, remember to define the operating system in the CFLAGS and link the library. Example:
```
gcc test.c -DLINUX -lnodave
```

## Authors

* **Thomas Hergenhan** - *The ENTIRE library* - [lettoz](https://sourceforge.net/u/lettoz/profile/)

