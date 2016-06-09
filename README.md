# opengrok-docker

OpenGrok is a fast and usable source code search and cross reference
engine, written in Java.

It helps you search, cross-reference and navigate source trees. It can understand various program file formats and version control histories.

This docker image support
- Mercurial
- Git
- Bazaar
- Subversion
- SCCS
- RCS
- CVS
- Monotone

## Usage
```sh
$ git clone https://github.com/OpenGrok/OpenGrok.git
$ docker run -t -i --rm \
    --name opengrok \
    -v ${PWD}/OpenGrok:/src \
    -v opengrok-data:/data \
    -p 8080:8080 \
    chihchun/opengrok
$ x-www-browser http://localhost:8080/source/
```

### trigger reindex

```sh
$ docker exec opengrok OpenGrok index
```

If you want opengrok reindex the source tree automatically for new changes,
pelase use -e OPENGROK_REINDEX=true

```sh
$ docker run -t -i --rm \
    --name opengrok \
    -e OPENGROK_REINDEX=true \
    -v ${PWD}/OpenGrok:/src \
    -v opengrok-data:/data \
    -p 8080:8080 \
    chihchun/opengrok
```
