# Development
FROM ubuntu:16.04

ARG uid=1000

# Install environment
RUN apt-get update -y
RUN apt-get install -y \ 
	git \
	wget \
	python3.5 \
	python3-pip \
	python-setuptools \
	python3-nacl \
	apt-transport-https \
	ca-certificates
RUN pip3 install -U \ 
	pip \ 
	setuptools \
	virtualenv
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BD33704C
RUN echo "deb https://repo.evernym.com/deb xenial master" >> /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install -y \ 
	python3-charm-crypto
RUN useradd -ms /bin/bash -u $uid indy
USER indy
RUN virtualenv -p python3.5 /home/indy/test
RUN cp -r /usr/local/lib/python3.5/dist-packages/Charm_Crypto-0.0.0.egg-info /home/indy/test/lib/python3.5/site-packages/Charm_Crypto-0.0.0.egg-info
RUN cp -r /usr/local/lib/python3.5/dist-packages/charm /home/indy/test/lib/python3.5/site-packages/charm
RUN mkdir /home/indy/.indy
USER root
RUN ln -sf /home/indy/test/bin/python /usr/local/bin/python
RUN ln -sf /home/indy/test/bin/pip /usr/local/bin/pip
USER indy
# TODO: Automate dependency collection
RUN pip install jsonpickle \
	ujson \
	prompt_toolkit==0.57 \
	pygments \
	crypto==1.4.1 \
	rlp \
	sha3 \
	leveldb \
	ioflo==1.5.4 \
	semver \
	base58 \
	orderedset \
	sortedcontainers==1.5.7 \
	psutil \
	pip \
	portalocker==0.5.7 \
	pyzmq \
	raet \
	ioflo==1.5.4 \
	psutil \
	intervaltree \
	pytest-xdist
ENV PYTHONPATH $PYTHONPATH:/home/indy/test/bin
WORKDIR /home/indy