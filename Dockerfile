FROM buildpack-deps:bionic

RUN set -ex; \
    useradd --create-home codewarrior; \
# TODO Remove symlink in the next version
    ln -s /home/codewarrior /workspace;

ENV OPAMROOT=/opt/opam \
    OPAMCOLOR=never

RUN set -ex; \
    mkdir -p $OPAMROOT; \
    chown codewarrior:codewarrior $OPAMROOT; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        m4 \
        rsync \
        aspcud \
    ; \
# Needed for opam 2.0
    add-apt-repository -y ppa:avsm/ppa; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        opam \
    ; \
    rm -rf /var/lib/apt/lists/*;

USER codewarrior
ENV USER=codewarrior \
    HOME=/home/codewarrior

# --disable-sandboxing is needed to do this in a container witout `--privileged`
RUN opam init -y --compiler=4.07.1 --disable-sandboxing

ENV OPAM_SWITCH_PREFIX=/opt/opam/4.07.1 \
    CAML_LD_LIBRARY_PATH=/opt/opam/4.07.1/lib/stublibs \
    OCAML_TOPLEVEL_PATH=/opt/opam/4.07.1/lib/toplevel \
    PATH=/opt/opam/4.07.1/bin:$PATH

RUN opam install -y \
        'ounit=2.0.8' \
        'batteries=2.9.0' \
        'core=v0.11.3' \
    ;

COPY workspace/test.ml /workspace/test.ml
COPY workspace/_tags /workspace/_tags
