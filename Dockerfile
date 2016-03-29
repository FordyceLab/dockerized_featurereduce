FROM ubuntu:14.04
MAINTAINER Tyler Shimko <tshimko@stanford.edu>

RUN sudo apt-get update -yq

RUN sudo apt-get install -yq \
    default-jdk \
    default-jre \
    git \
    r-base \
    r-base-dev \
    wget

ENV HOME /root

WORKDIR $HOME

RUN JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))

RUN pwd &&\
    R CMD javareconf &&\
    wget https://cran.r-project.org/src/contrib/Archive/rJava/rJava_0.6-3.tar.gz &&\
    tar -xzf rJava_0.6-3.tar.gz &&\
    R CMD INSTALL rJava &&\
    rm -r rJava rJava_0.6-3.tar.gz

RUN wget https://cran.r-project.org/src/contrib/nnls_1.4.tar.gz  &&\
    tar -xzf nnls_1.4.tar.gz &&\
    R CMD INSTALL nnls &&\
    rm -r nnls nnls_1.4.tar.gz

RUN wget https://cran.r-project.org/src/contrib/Matrix_1.2-4.tar.gz &&\
    tar -xzf Matrix_1.2-4.tar.gz &&\
    R CMD INSTALL Matrix &&\
    rm -r Matrix Matrix_1.2-4.tar.gz

RUN wget https://cran.r-project.org/src/contrib/Archive/MASS/MASS_7.3-27.tar.gz &&\
    tar -xzf MASS_7.3-27.tar.gz &&\
    R CMD INSTALL MASS &&\
    rm -r MASS MASS_7.3-27.tar.gz

ENV R_HOME=/usr/lib/R

ENV RJAVA_HOME=/usr/local/lib/R

ENV R_SHARE_DIR=/usr/share/R/share

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RJAVA_HOME/site-library/rJava/jri

ENV CLASSPATH=$CLASSPATH:$HOME/freduce/bin:$HOME/freduce/bin/biojava.jar:\
$HOME/freduce/bin/Biojava.suppl.v1.01.jar:\
$HOME/freduce/bin/bytecode.jar:\
$HOME/freduce/bin/commons-cli.jar:\
$HOME/freduce/bin/commons-collections-2.1.jar:\
$HOME/freduce/bin/commons-pool-1.1.jar:\
$HOME/freduce/bin/trove-3.0.2.jar:\
$HOME/freduce/bin/jfreechart-1.0.13.jar:\
$HOME/freduce/bin/jcommon-1.0.16.jar:\
$RJAVA_HOME/site-library/rJava/jri/JRI.jar:\
$HOME/freduce/bin/commons-lang-2.4.jar:\
$HOME/freduce/bin/itextpdf-5.1.0.jar

ENV DISPLAY=:1.0

RUN git clone https://github.com/FeatureREDUCE/FeatureREDUCE.git &&\
    mv FeatureREDUCE/freduce freduce &&\
    rm -r FeatureREDUCE &&\
    cd freduce/bin &&\
    jar xf Biojava.suppl.v1.02.jar

ENTRYPOINT /bin/bash

