# OCaml Image

Container image for OCaml used by CodeRunner.

## Usage

```bash
W=/workspace/
# Create container
C=$(docker container create --rm -w $W ghcr.io/codewars/ocaml:latest \
    sh -c 'ocamlbuild -quiet -use-ocamlfind test.native && exec ./test.native')

# Write solution and tests in workspace/fixture.ml
# Then copy it inside a container
docker container cp workspace/fixture.ml $C:$W/fixture.ml

# Run tests
docker container start --attach $C
```

## Building

```bash
docker build -t ghcr.io/codewars/ocaml:latest .
```
