FROM ubuntu:22.04

RUN set -ex; \
    useradd --create-home codewarrior; \
    mkdir -p /workspace; \
    chown -R codewarrior:codewarrior /workspace;

ENV OPAMROOT=/opt/opam \
    OPAMCOLOR=never

RUN set -ex; \
    mkdir -p $OPAMROOT; \
    chown codewarrior:codewarrior $OPAMROOT; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        libgmp-dev \
        opam \
    ;

USER codewarrior
ENV USER=codewarrior \
    HOME=/home/codewarrior

RUN opam init -y --shell-setup --compiler=4.14.0 --disable-sandboxing

RUN opam install -y \
        'ounit2=2.2.6' \
        'ocamlfind=1.9.3' \
        'ocamlbuild=0.14.1' \
        'zarith=1.12' \
        'batteries=3.5.1' \
        'core=v0.15.0' \
    ;

ENV OPAM_SWITCH_PREFIX=$OPAMROOT/4.14.0 \
    CAML_LD_LIBRARY_PATH=$OPAMROOT/4.14.0/lib/stublibs:$OPAMROOT/4.14.0/lib/ocaml/stublibs:$OPAMROOT/4.14.0/lib/ocaml \
    OCAML_TOPLEVEL_PATH=$OPAMROOT/4.14.0/lib/toplevel \
    PATH=$OPAMROOT/4.14.0/bin:$PATH

COPY workspace/test.ml /workspace/test.ml
COPY workspace/_tags /workspace/_tags