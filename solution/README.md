## Run Virtuoso using the `docker` command

### On Linux and Mac

```bash
docker run --rm -it --name virtuoso -p 8890:8890 -p 1111:1111 -e DBA_PASSWORD=dba -e SPARQL_UPDATE=true -e DEFAULT_GRAPH=https://w3id.org/um/ids/graph -v $(pwd)/data/virtuoso:/data tenforce/virtuoso
```

> Access on http://localhost:8890

You can make it multiline for readability:

```bash
docker run --rm -it --name virtuoso \
    -p 8890:8890 -p 1111:1111 \
    -e DBA_PASSWORD=dba \
    -e SPARQL_UPDATE=true \
    -e DEFAULT_GRAPH=https://w3id.org/um/ids/graph \
    -v $(pwd)/data/virtuoso:/data \
    tenforce/virtuoso
```

### On Windows

Use `${PWD}` for current directory

```powershell
docker run --rm -it --name virtuoso -p 8890:8890 -p 1111:1111 -e DBA_PASSWORD=dba -e SPARQL_UPDATE=true -e DEFAULT_GRAPH=https://w3id.org/um/ids/graph -v ${PWD}/data/virtuoso:/data tenforce/virtuoso
```

### Use an absolute path

For the volume (here store Virtuoso data in `/data/virtuoso`)

```bash
docker run --rm -it --name virtuoso -p 8890:8890 -p 1111:1111 -e DBA_PASSWORD=dba -e SPARQL_UPDATE=true -e DEFAULT_GRAPH=https://w3id.org/um/ids/graph -v /data/virtuoso:/data tenforce/virtuoso
```

### Delete the container

```bash
docker rm virtuoso
```

