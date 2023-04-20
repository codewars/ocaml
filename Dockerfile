FROM ubuntu:22.04 AS Builder

ENV OPAMROOT=/opt/ocaml

RUN set -ex; \
    mkdir -p $OPAMROOT; \
    useradd --create-home codewarrior; \
    chown codewarrior:codewarrior $OPAMROOT; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        libgmp-dev \
        opam \
    ;

USER codewarrior
ENV USER=codewarrior

RUN set -ex; \
    opam init -y --shell-setup --disable-sandboxing --compiler=5.0.0;

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

FROM ubuntu:22.04

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        gcc \
        libc6-dev \
        libgmp-dev \
    ; \
    rm -rf /var/lib/apt/lists/*;

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
    useradd --create-home codewarrior; \
    mkdir -p /workspace; \
    chown -R codewarrior:codewarrior /workspace;

USER codewarrior
ENV USER=codewarrior \
    PATH=/opt/ocaml/5.0.0/bin:$PATH

COPY --chown=codewarrior:codewarrior workspace/. /workspace/
WORKDIR /workspace
