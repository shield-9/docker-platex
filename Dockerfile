FROM frolvlad/alpine-glibc:alpine-3.8
#FROM alpine:3.8

COPY texlive.profile .

RUN WORK_DIR="$(mktemp -d)" && cd $WORK_DIR && \
	apk --no-cache add perl=5.26.2-r1 wget=1.19.5-r0 xz=5.2.4-r0 tar=1.30-r0 && \
	wget -qO - ftp://tug.org/historic/systems/texlive/2018/install-tl-unx.tar.gz | \
	tar xz -C . --strip-components=1 && \
	./install-tl --profile=texlive.profile && \
	apk --no-cache del perl wget xz tar && \
	cd && rm -rf $WORK_DIR


RUN apk --no-cache add bash


#RUN apt-get -q update && \
#	apt-get -qy install texlive texlive-lang-cjk dvipsk-ja texlive-fonts-recommended texlive-fonts-extra texinfo texlive-latex-extra biber && \
#	rm -rf /var/lib/apt/lists/*

VOLUME /latex
WORKDIR /latex

COPY build /usr/bin/

ENTRYPOINT ["bash"]
