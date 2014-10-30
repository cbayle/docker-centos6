# Build a simple docker image using rinse
docker-centos6: depends	scratch
	sudo /usr/share/docker.io/contrib/mkimage.sh -t cbayle/centos6 rinse --distribution centos-6

# docker seems to require a scratch image, so not pull from internet, I import it in the local repository
# See http://docs.docker.com/articles/baseimages/
scratch: depends
	tar cv --files-from /dev/null | docker import - scratch

depends: /usr/sbin/rinse /usr/bin/strings /usr/bin/docker

/usr/bin/docker:
	sudo apt-get install docker.io

/usr/bin/strings:
	sudo apt-get install binutils

/usr/sbin/rinse:
	sudo apt-get install rinse


