#!/usr/bin/env sh

git clone --recursive https://github.com/thestinger/termite.git
git clone https://github.com/thestinger/vte-ng.git

sudo apt-get install gtk-doc-tools libglib2.0-dev gobject-introspection valac \
	             libpango1.0-dev libgtk-3-dev libgnutls-dev g++ git\
		     libgirepository1.0-dev libxml2-utils gperf

mkdir devenv

cd vte-ng && ./autogen.sh --prefix=$(realpath ../devenv) && make -j$(nproc) && make install

cd ../termite
sed -i 's/$</$< ..\/devenv\/lib\/libvte-2.91.a/' Makefile
sed -i 's/${DESTDIR}\/etc/${DESTDIR}{PREFIX}\/etc/' Makefile
PKG_CONFIG_PATH=$(realpath ../devenv/lib/pkgconfig) make -j$(nproc)

echo "##############################README#######################################"
echo "Check if termite is working by executing:"
echo ""
echo "	$ ./termite/termite"
echo ""
echo "termite should open now."
echo ""
echo "If you get \"'xterm-termite': unknown terminal type\" after executing 'clear'"
echo "simply add \"TERM=xterm-256color\" to your .bashrc and restart termite"
echo ""
echo "INSALLATION:"
echo ""
echo "If everything is working you can install termite."
echo "You can install termite local or systemwide."
echo "You can ignore the message that vte-2.91 was not found."
echo ""
echo ""
echo "For a local install execute:"
echo ""
echo "	$ make -C termite/ PREFIX=$(realpath ~/.local) install"
echo ""
echo ""
echo "For systemwide install execute:"
echo ""
echo "	$ sudo make -C termite/ install"
echo ""
echo ""
echo "###########################################################################"
echo ""

