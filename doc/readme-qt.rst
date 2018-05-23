Beetle-qt: Qt5 GUI for Beetle
===============================

Build instructions
===================

Debian
-------

First, make sure that the required packages for Qt5 development of your
distribution are installed, for Debian and Ubuntu these are:

::

    apt-get install qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools \
        build-essential libboost-dev libboost-system-dev \
        libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev \
        libssl-dev libdb++-dev libminiupnpc-dev

then execute the following:

::

    qmake
    make

Alternatively, install Qt Creator and open the `Beetle-qt.pro` file.

An executable named `Beetle-qt` will be built.


Windows
--------

Windows build instructions:

- Download the `QT Windows SDK`_ and install it. You don't need the Symbian stuff, just the desktop Qt.

- Compile openssl, boost and dbcxx.

- Open the .pro file in QT creator and build as normal (ctrl-B)

.. _`QT Windows SDK`: http://qt-project.org/downloads


Mac OS X
--------

- Download and install the `Qt Mac OS X SDK`_. It is recommended to also install Apple's Xcode with UNIX tools.

- Download and install `MacPorts`_.

- Execute the following commands in a terminal to get the dependencies:

::

	sudo port selfupdate
	sudo port install boost db48 miniupnpc

- Open the .pro file in Qt Creator and build as normal (cmd-B)

.. _`Qt Mac OS X SDK`: http://qt-project.org/downloads
.. _`MacPorts`: http://www.macports.org/install.php


Build configuration options
============================

UPNnP port forwarding
---------------------

To use UPnP for port forwarding behind a NAT router (recommended, as more connections overall allow for a faster and more stable Beetle experience), pass the following argument to qmake:

::

    qmake "USE_UPNP=1"

(in **Qt Creator**, you can find the setting for additional qmake arguments under "Projects" -> "Build Settings" -> "Build Steps", then click "Details" next to **qmake**)

This requires miniupnpc for UPnP port mapping.  It can be downloaded from
http://miniupnp.tuxfamily.org/files/.  UPnP support is not compiled in by default.

Set USE_UPNP to a different value to control this:

+------------+--------------------------------------------------------------------------+
| USE_UPNP=- | no UPnP support, miniupnpc not required;                                 |
+------------+--------------------------------------------------------------------------+
| USE_UPNP=0 | (the default) built with UPnP, support turned off by default at runtime; |
+------------+--------------------------------------------------------------------------+
| USE_UPNP=1 | build with UPnP support turned on by default at runtime.                 |
+------------+--------------------------------------------------------------------------+

Notification support for recent (k)ubuntu versions
---------------------------------------------------

To see desktop notifications on (k)ubuntu versions starting from 10.04, enable usage of the
FreeDesktop notification interface through DBUS using the following qmake option:

::

    qmake "USE_DBUS=1"

Generation of QR codes
-----------------------

libqrencode may be used to generate QRCode images for payment requests. 
It can be downloaded from http://fukuchi.org/works/qrencode/index.html.en, or installed via your package manager. Pass the USE_QRCODE 
flag to qmake to control this:

+--------------+--------------------------------------------------------------------------+
| USE_QRCODE=0 | (the default) No QRCode support - libarcode not required                 |
+--------------+--------------------------------------------------------------------------+
| USE_QRCODE=1 | QRCode support enabled                                                   |
+--------------+--------------------------------------------------------------------------+


Berkely DB version warning
==========================

A warning for people using the *static binary* version of Beetle on a Linux/UNIX-ish system (tl;dr: **Berkely DB databases are not forward compatible**).

The static binary version of Beetle is linked against libdb 5.0 (see also `this Debian issue`_).

Now the nasty thing is that databases from 5.X are not compatible with 4.X.

If the globally installed development package of Berkely DB installed on your system is 5.X, any source you
build yourself will be linked against that. The first time you run with a 5.X version the database will be upgraded,
and 4.X cannot open the new format. This means that you cannot go back to the old statically linked version without
significant hassle!

.. _`this Debian issue`: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=621425

Ubuntu 11.10 warning
====================

Ubuntu 11.10 has a package called 'qt-at-spi' installed by default.  At the time of writing, having that package
installed causes Beetle-qt to crash intermittently.  The issue has been reported as `launchpad bug 857790`_, but
isn't yet fixed.

Until the bug is fixed, you can remove the qt-at-spi package to work around the problem, though this will presumably
disable screen reader functionality for Qt apps:

::

    sudo apt-get remove qt-at-spi

.. _`launchpad bug 857790`: https://bugs.launchpad.net/ubuntu/+source/qt-at-spi/+bug/857790



QT5 MINGW WINDOWS LATEST TUTORIAL
***************************************



> Download Get install file msys2-$ARCH-*.exe from https://msys2.github.io, where $ARCH is i686 or x86_64 (matching your system).

> Open MSYS32 SHELL

> pacman -Suy python git make tar zip mingw-w64-i686-gcc mingw-w64-i686-libpng mingw-w64-i686-zlib python
> pacman -S msys/libtool
> pacman -S msys/autoconf
> pacman -S msys/automake-wrapper perl
> mkdir /c/devel && cd /c/devel

$ wget http://download.oracle.com/berkeley-db/db-4.8.30.tar.gz
$ tar xzf db-4.8.30.tar.gz
$ cd db-4.8.30/build_unix
$ ../dist/configure --enable-mingw --enable-cxx --disable-replication --prefix=/mingw32
$ make -j <threads> && make install

cd /c/devel/
$ wget http://download.qt.io/official_releases/qt/5.9/5.9.2/single/qt-everywhere-opensource-src-5.9.2.zip
$ unzip qt-everywhere-opensource-src-5.9.2.zip
$ cd qt-everywhere-opensource-src-5.9.2
$ CXXFLAGS="--Wno-deprecated-declarations" ./configure -static -release -opensource -confirm-license -platform win32-g++ -prefix "C:\devel\qt5.9.2-static" -nomake examples -nomake tools -opengl desktop -no-angle -make libs -qt-zlib -qt-libpng -qt-libjpeg -qt-freetype -qt-pcre -sql-sqlite
$ make -j <threads> && make install

for qt4.8.6:

> ugly hack: cp C:\msys64\usr\bin\make.exe C:\msys64\usr\bin\mingw32-make.exe
> (in win cmd): ./configure -release -opensource -confirm-license -static -no-sql-sqlite -no-qt3support -no-opengl -qt-zlib -no-gif -qt-libpng -qt-libmng -no-libtiff -qt-libjpeg -no-dsp -no-vcproj -no-openssl -no-dbus -no-phonon -no-phonon-backend -no-multimedia -no-audio-backend -no-webkit -no-script -no-scripttools -no-declarative -no-declarative-debug -qt-style-windows -qt-style-windowsxp -qt-style-windowsvista -nomake demos -nomake examples -platform win32-g++
> make -j4

Download miniupnpc-1.9 and extract to /c/devel

download mminiupnpc-1.9.20150206.tar
> cd /c/devel/miniupnpc-1.9
Edi Makefile.mingw change line 72 to "wingen..." --> ./wingenminiupnpcstrings"
> make -f Makefile.mingw init upnpc-static
> mkdir miniupnpc
> cp *.h miniupnpc

BOOST INSTALL:
>  Download boost 1_55_0 to your deps folder from here http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.7z/download
> cd C:\deps\boost_1_55_0\
> ./bootstrap.bat mingw
> ./b2 --build-type=complete --with-test --with-chrono --with-filesystem --with-program_options --with-system --with-thread toolset=gcc variant=release link=static threading=multi runtime-link=static stage

OPENSSL INSTAL:
> wget https://www.openssl.org/source/openssl-1.0.2o.tar.gz
> tar xzvf openssl-1.0.2o.tar.gz
> cd openssl-1.0.2o
> perl Configure mingw no-shared no-asm
> make depend
> make


*OPEN MSYS W32 SHELL*
> cd /c/Users/XXX/COINS/STY/StyleCoin/src/leveldb
> TARGET_OS=NATIVE_WINDOWS make libleveldb.a libmemenv.a

*OPEN MSYS W32 SHELL AGAIN*
cd /COINPATH/src/secp2561k
> ./autogen.sh
> ./configure --enable-module-recovery --with-bignum=no
> make -j4
> make install
> cp include/*.h /mingw32/include/

