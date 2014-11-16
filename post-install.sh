#!/bin/sh
#
#  post-install.sh
#  CentOS 6

prefix=$1

if [ ! -d "${prefix}" ]; then
  echo "Serious error - the named directory doesn't exist."
  exit
fi

# rpm's can now be removed
rm -f ${prefix}/*.rpm

touch ${prefix}/etc/mtab

echo "  Bootstrapping yum"
chroot ${prefix} /usr/bin/yum -y install \
coreutils-libs curl db4-utils device-mapper-libs gzip hwdata libffi libgpg-error libproxy libudev libusb ncurses-base nss-tools shared-mime-info groff less libproxy-bin libproxy-python pkgconfig gamin gnutls gpgme pakchois gnupg2 pinentry pth cronie cronie-anacron cyrus-sasl mysql-libs postfix \
yum vim-minimal dhclient 2>/dev/null

echo "  cleaning up..."
chroot ${prefix} /usr/bin/yum clean all 
umount ${prefix}/proc
umount ${prefix}/sys

# Install modprobe
if [ -e "${prefix}/etc/modprobe.d/modprobe.conf.dist" ]; then
    cp  "${prefix}/etc/modprobe.d/modprobe.conf.dist" "${prefix}/etc/modprobe.conf"
fi

echo "  post-install.sh : done."
