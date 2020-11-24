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

---

## Run JupyterLab with docker-compose

In your terminal, go to the `solution` folder in the workshop directory:

```bash
cd solution
```

### Task 3 with build

Build and start custom JupyterLab from `Dockerfile`, and Virtuoso triplestore:

```bash
docker-compose up --build
```

### Task 3 advanced with official image

Recreate the `data/jupyterlab` folder in `solution` to run the docker-compose in this folder:

```powershell
sudo mkdir -p data/jupyterlab
sudo chown -R 1000:1000 data/jupyterlab
```

Start official JupyterLab, and Virtuoso triplestore:

```bash
docker-compose -f docker-compose.advanced.yml up
```

---

## Stop the containers

With docker-compose:

```bash
docker-compose down
```

With docker:

If facing issues when starting a new container due to already existing container:

```bash
docker stop virtuoso
docker stop jupyterlab
docker rm virtuoso
docker rm jupyterlab
```

