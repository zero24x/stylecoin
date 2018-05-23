set PATH=%PATH%;C:\devel\qt5.5.0-static\bin
cd "%cd%"
qmake USE_UPNP=1 USE_IPV6=1 USE_QRCODE=1 StyleCoin.pro
make -f Makefile.Release -j4
pause
build_qt_static.bat