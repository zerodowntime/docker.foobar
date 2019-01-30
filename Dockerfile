FROM centos:7

ARG ARG_TEST=hello

RUN echo $ARG_TEST
