# OCaml Image

Container image for OCaml used by CodeRunner.

## Usage

```bash
W=/workspace
# Create container
BUILD="ocamlbuild -quiet -use-ocamlfind cwtest.native"
C=$(docker container create --rm -w $W ghcr.io/codewars/ocaml:latest sh -c "$BUILD && exec ./cwtest.native")

# Copy solution and test files
docker container cp ${1:-examples/basic}/. $C:$W

# Start
docker container start --attach $C
```

## Building

```bash
docker build -t ghcr.io/codewars/ocaml:latest .
```
