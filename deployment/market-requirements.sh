# install imagemagick for thumbnails

# to support png, jpeg
yum install -y  libpng-devel  libjpeg-devel

# to support webp for 64 bit centos 6.5
wget libwebp-devel http://rpms.famillecollet.com/enterprise/6/remi/x86_64/libwebp-devel-0.3.1-2.el6.remi.x86_64.rpm
wget libwebp-devel http://rpms.famillecollet.com/enterprise/6/remi/x86_64/libwebp-0.3.1-2.el6.remi.x86_64.rpm
rpm -hiv libwebp-devel-0.3.1-2.el6.remi.x86_64.rpm libwebp-0.3.1-2.el6.remi.x86_64.rpm

mkdir imagemagick
cd imagemagick
wget ftp://ftp.imagemagick.org/pub/ImageMagick/ImageMagick.tar.gz
tar xvfz ImageMagick.tar.gz
cd ImageMagick-6.6.5-8
./configure --with-webp=yes --with-png --with-jpeg --disable-share
make
sudo make install
sudo ldconfig /usr/local/lib


# list delegate
identify -list configure
