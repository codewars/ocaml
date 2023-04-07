FROM alpine:3.17 AS builder

ENV OPAMROOT=/opt/ocaml

RUN set -ex; \
    mkdir -p $OPAMROOT; \
    adduser -D codewarrior; \
    chown -R codewarrior:codewarrior /opt/ocaml; \
    apk update; \
    apk add --virtual .build-deps \
        build-base \
        ocaml-compiler-libs \
        gmp-dev \
        opam \
    ;

USER codewarrior
ENV USER=codewarrior

RUN set -ex; \
    opam init -y --disable-sandboxing --compiler=5.0.0;

RUN set -ex; \
    opam install -y \
        'batteries=3.6.0' \
        'base=v0.15.1' \
        'domainslib=0.5.0' \
        'ocamlbuild=0.14.2' \
        'ocamlfind=1.9.6' \
        'ounit2=2.2.7' \
        'zarith=1.12' \
    ;

FROM alpine:3.17

RUN set -ex; \
    apk add --no-cache \
        gcc \
        gmp-dev \
        musl-dev \
    ;

COPY --from=builder \
    /opt/ocaml/5.0.0/bin/ocamlc.opt \
    /opt/ocaml/5.0.0/bin/ocamlopt.opt \
    /opt/ocaml/5.0.0/bin/ocamldep.opt \
    /opt/ocaml/5.0.0/bin/ocamlbuild \
    /opt/ocaml/5.0.0/bin/ocamlfind \
    /opt/ocaml/5.0.0/bin/
COPY --from=builder \
    /opt/ocaml/5.0.0/lib/ /opt/ocaml/5.0.0/lib/

RUN set -ex; \
    adduser -D codewarrior; \
    mkdir /workspace; \
    chown -R codewarrior:codewarrior /workspace;

USER codewarrior
ENV USER=codewarrior \
    PATH=/opt/ocaml/5.0.0/bin:$PATH

COPY --chown=codewarrior:codewarrior workspace/. /workspace/
WORKDIR /workspace\