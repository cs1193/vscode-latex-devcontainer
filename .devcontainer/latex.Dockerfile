FROM ubuntu:20.04

RUN apt update -y
RUN apt install -y wget curl jq
RUN apt install -y texlive-full
