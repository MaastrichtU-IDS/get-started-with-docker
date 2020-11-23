A workshop to get started with Docker in an hour (hopefully), after during this workshop you will:

* Find and run a Docker image for a database service (a Virtuoso triplestore)
* Define a `docker-compose.yml` file to run a JupyterLab container alongside the database
* Run the JupyterLab container as restricted or admin user
* Customize an existing image by installing new packages and changing the user (JupyterLab)

Pre-requisites:

* Docker and docker-compose installed
* Really basic knowledge of how to use the terminal:
  * List files in current directory: `ls`
  * Change directory: `cd subfolder`
  * Find your current directory: `pwd`
  * When defining a path, the dot `.` defines the current directory, it is usually used at the start of the path, e.g. `./data` for the data folder in the current directory)
  * Use 2 dots to go to the parent folder: `cd ..`

## Get the workshop files

Use `git` to clone the repository 📥

1. Open your terminal
2. Go to the directory where you want to store the workshop folder
3. Run:

```bash
git clone https://github.com/MaastrichtU-IDS/get-started-with-docker
```

> If you don't have `git` installed you can also [download the workshop as a `.zip` file](https://github.com/MaastrichtU-IDS/get-started-with-docker/archive/master.zip) and unzip it.

4. **Go the workshop folder in your terminal**:

```bash
cd get-started-with-docker
```

> For the whole workshop we assume you are running the terminal commands from this directory.

## Task 1: Find and start a database container

We want to start the [OpenLink Virtuoso database](http://vos.openlinksw.com/owiki/wiki/VOS) (a triplestore for RDF data) without loosing time installing all the required packages and setting up the configuration. We will then use a Docker container.

1. 👨‍💻 Search for [**"virtuoso docker" on Google**](https://www.google.com/search?q=virtuoso+docker) (or your favorite search engine).

2. Various image should be found. Here is a few advices to pick the right existing Docker image for a service:

    * Check for recent image that seems to be kept up-to-date (with an active community or company behind if possible)
    * Check the number of downloads to see how popular it is
    * You can also check how the application is installed in the [Dockerfile](https://github.com/tenforce/docker-virtuoso/blob/master/Dockerfile) (when source code available)
    * Note that currently most existing images are available on DockerHub, but things are changing. Using an image from a different registry does not change anything else than the start of the Image name (quay.io, ghcr.io...)
      * It is recommended to login to the Container Registries if you have a user (DockerHub, GitHub), it will award you greater download limitations.

3. 👨‍💻 Follow the instructions from [tenforce/virtuoso](https://hub.docker.com/r/tenforce/virtuoso/) to start the Virtuoso triplestore using the `docker run` command. You will just need to change the shared volume:

    * They defined `-v /my/path/to/the/virtuoso/db:/data \`

    * Change it to the `data/virtuoso` folder in your current directory, the path on the left of the `:` is for your computer, the path on the right is where the volume is shared in the container.

    * To provide the current directory as shared volume with the docker container the variable to use is different for Windows:
      * For Linux and Mac use (use `\` at the end if you are using a command defined on multiple lines):

      ```bash
      -v $(pwd)/data/virtuoso:/data \
      ```

      * For Windows, remove all the newlines with their extra `\`, and use:

      ```powershell
      -v ${PWD}/data/virtuoso:/data
      ```

👨‍💻 Access the Virtuoso triplestore on http://localhost:8890

## Task 2: Start the container with docker-compose

Open the `docker-compose.yml` file provided in the workshop folder with your favorite IDE (we recommend VisualStudio Code if you don't know which one to use)

Follow [tenforce/virtuoso](https://hub.docker.com/r/tenforce/virtuoso/) instructions to define a `docker-compose.yml` file to run Virtuoso, and make some changes:

* Define a fixed container name: `container_name: virtuoso` 
* Change the `DBA_PASSWORD` to `dba`
* Change the `DEFAULT_GRAPH` to https://w3id.org/um/ids/graph

> N.B.: In the `docker-compose.yml` file you can use the current directory of the yml file to store the container data, use `.` at the start of the volume path:
>
> ```yaml
>     volumes:
>       - ./data/virtuoso:/data
> ```

Open your terminal and go to he directory where the `docker-compose.yml` is stored.

👨‍💻 Start the containers defined in the `docker-compose.yml` file:

```bash
docker-compose up
```

You can check running Docker containers on your laptop via the Docker Desktop UI or running this command in the terminal:

```bash
docker ps
```

> Try to access the Virtuoso triplestore running on http://localhost:8890/sparql

Stop the docker-compose running in your terminal by hitting the keys `ctrl + C`

👨‍💻 Run the containers detached from your terminal (in the background):

```bash
docker-compose up -d
```

👨‍💻 Stop the running containers:

```bash
docker-compose down
```

## Task 3: Add a JupyterLab to the docker-compose

We will **add a JupyterLab to the docker-compose**, and use it to query the Virtuoso triplestore.

https://github.com/MaastrichtU-IDS/jupyterlab-on-openshift/

We will use a JupyterLab image with SPARQL libraries hosted on the [MaastrichU-IDS GitHub Container Registry](https://github.com/orgs/MaastrichtU-IDS/packages/container/package/jupyterlab-on-openshift).

1. Add the `jupyterlab` service to your `docker-compose.yml`:

```yaml
version: "3"
services:
  jupyterlab:
    container_name: jupyterlab
    image: ghcr.io/maastrichtu-ids/jupyterlab-on-openshift
    environment:
      - JUPYTER_TOKEN=password
      - JUPYTER_ENABLE_LAB=yes
    volumes:
      - ./data/jupyterlab:/home/jovyan
```

👨‍💻 You will need to add:

* The Jupyter notebooks port used by the image: `8888`
* The shared volume on `./data/jupyterlab:/home/jovyan`

⚠️ The official Jupyter Docker image uses the `jovyan` user by default which does not have admin rights (`sudo`). This can cause issues when writing to the shared volumes, to fix it you can change the owner of the folder or start JupyterLab as root user.

2. Create the folder with the right permissions before starting the containers:

You can create the folder you will use to store JupyterLab data, and define the right permissions, before running the JupyterLab container:

```bash
mkdir -p data/jupyterlab
sudo chown -R 1000:1000 data/jupyterlab
```

3. Start JupyterLab and Virtuoso:

```bash
docker-compose up
```

> ⚠️ If you are still experiencing issue with the folder permissions (e.g. impossible to create or save a file in JupyterLab) go directly to **Task 4** to run JupyterLab with admin rights.

4. Query the Virtuoso database from JupyterLab on http://localhost:8888
   
   * Create a **SPARQL notebook**
   
   * Create a cell to define the triplestore SPARQL endpoint URL:
   
     ```SPARQL
     %endpoint http://db:8890/sparql
     SELECT * WHERE {
         ?s ?p ?o .
     } LIMIT 10
     ```
   
   * Now **run the cell** to query the triplestore from the notebook 🚀

## Task 4: Run JupyterLab with admin rights

You can also run JupyterLab with the `root` user to have admin rights 🔑

> 👨‍💻 Stop the previously ran Jupyterlab container (`ctrl + C` or `docker-compose down`)
>
> Delete the folder created to store the JupyterLab data (you might need to use `sudo`):
>
> ```bash
> rm -rf data
> ```

We will now change the `docker-compose.yml` to start JupyterLab with the root user.

Add the following parameters at the right place in the `docker-compose.yml`:

```yaml
services:
  jupyterlab:
    user: root
    environment:
      - GRANT_SUDO=yes
```

👨‍💻 Restart JupyterLab and Virtuoso:

```bash
docker-compose up --force-recreate
```

1. You should now be able to install anything in the JupyterLab container. Open a terminal in JupyterLab and try to install a package:

   ```bash
   sudo apt install vim
   ```

2. Create again a **SPARQL notebook** to query the SPARQL endpoint:

   ```SPARQL
   %endpoint http://db:8890/sparql
   SELECT * WHERE {
       ?s ?p ?o .
   } LIMIT 10
   ```


## Task 5: Customize the Dockerfile

We will improve the `Dockerfile` of the JupyterLab container to have a custom image with additional packages installed 📦

> See the [GitHub repository for the JupyterLab image](https://github.com/MaastrichtU-IDS/jupyterlab-on-openshift/).

Use the `Dockerfile` provided in the workshop folder to define your image.

We start from the JupyterLab image we were previously using:

```dockerfile
FROM ghcr.io/maastrichtu-ids/jupyterlab-on-openshift
```

👨‍💻 You will need to:

1. Change the user to `root` (to have admin rights by default)

2. Install the python package `rdflib` with `pip` (bonus: you can use the `requirements.txt` file to install the `rdflib` package in the container)

3. Download the `.jar` file of the RML-mapper in the `/opt` folder:

```bash
wget -O /opt/rmlmapper.jar https://github.com/RMLio/rmlmapper-java/releases/download/v4.9.0/rmlmapper.jar
```

4. Go in the `docker-compose.yml` to build the container from the local `Dockerfile` instead of using an image from a Container Registry:

```yaml
services:
  jupyterlab:
    # image: ghcr.io/maastrichtu-ids/jupyterlab-on-openshift
    build: .
```

👨‍💻 Build and restart JupyterLab:

```bash
docker-compose up --build
```

You can also build the image using the `docker` command:

```bash
docker build -t my-jupyterlab .
```

## Checkout the solution ✔️

Go in the `solution` folder to check the solution:

* `docker-compose.yml` with root JupyterLab and Virtuoso
* `Dockerfile` with root user and additional packages installed