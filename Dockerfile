FROM frolvlad/alpine-glibc:alpine-3.8

COPY texlive.profile .

RUN WORK_DIR="$(mktemp -d)" && cd $WORK_DIR && \
	apk --no-cache add perl=5.26.3-r0 wget=1.20.1-r0 xz=5.2.4-r0 tar=1.30-r0 && \
	wget -qO - ftp://tug.org/historic/systems/texlive/2018/install-tl-unx.tar.gz | \
	tar xz -C . --strip-components=1 && \
	./install-tl --profile=/texlive.profile && \
	apk --no-cache del perl wget xz tar && \
	cd && rm -rf $WORK_DIR


RUN apk --no-cache add bash

ENV PATH="/usr/local/texlive/2018/bin/x86_64-linuxmusl:${PATH}"

VOLUME /latex
WORKDIR /latex

COPY biber tex2pdf tex2pdf-pbibtex /usr/bin/

#ENTRYPOINT ["bash"]
ENTRYPOINT ["tex2pdf"]
