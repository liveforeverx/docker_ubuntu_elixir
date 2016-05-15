FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install curl wget

RUN curl -o /tmp/erlang.deb http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i /tmp/erlang.deb
RUN rm -rf /tmp/erlang.deb

ENV REFRESHED_AT 2016-05-09

RUN apt-get update

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install locales

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_COLLATE en_US.UTF-8

RUN apt-get install -y vim tar make build-essential checkinstall libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev git esl-erlang

########## ELIXIR ##########
WORKDIR /usr/local/src
RUN git clone https://github.com/elixir-lang/elixir.git
WORKDIR /usr/local/src/elixir
RUN make clean install
RUN mix local.hex --force
RUN mix local.rebar --force
WORKDIR /

######### POSTGRES #########
RUN apt-get install postgresql-client

