## Run Virtuoso using the `docker` command

### On Linux and Mac

```bash
docker run --rm -it --name virtuoso -p 8890:8890 -p 1111:1111 -e DBA_PASSWORD=dba -e SPARQL_UPDATE=true -e DEFAULT_GRAPH=https://w3id.org/um/ids/graph -v $(pwd)/data/virtuoso:/data -d tenforce/virtuoso
```

You can make it multiline for readability:

```bash
docker run --rm -it --name virtuoso \
    -p 8890:8890 -p 1111:1111 \
    -e DBA_PASSWORD=dba \
    -e SPARQL_UPDATE=true \
    -e DEFAULT_GRAPH=https://w3id.org/um/ids/graph \
    -v $(pwd)/data/virtuoso:/data \
    -d tenforce/virtuoso
```

### On Windows

Use `${PWD}` for current directory

```powershell
docker run --rm -it --name virtuoso -p 8890:8890 -p 1111:1111 -e DBA_PASSWORD=dba -e SPARQL_UPDATE=true -e DEFAULT_GRAPH=https://w3id.org/um/ids/graph -v ${PWD}/data/virtuoso:/data -d tenforce/virtuoso
```

### Delete the container

```bash
docker rm virtuoso
```

