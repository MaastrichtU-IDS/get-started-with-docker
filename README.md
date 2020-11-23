# Get started with Docker 🐳

A workshop to get started with Docker in an hour 🕐 (hopefully).

During this workshop you will:

* Find and run a Docker image for a database service (a Virtuoso triplestore for RDF data)
* Define a `docker-compose.yml` file to run a JupyterLab container alongside the database
* Run the JupyterLab container as restricted or admin user
* Customize an existing image by installing new packages and changing the user (JupyterLab)

Pre-requisites:

* [Docker](https://docs.docker.com/get-docker/) and docker-compose installed
* Really basic knowledge of how to use the terminal:
  * List files in current directory: `ls`
  * Change directory: `cd subfolder`
  * Find your current directory: `pwd`
  * When defining a path, the dot `.` defines the current directory, it is usually used at the start of the path, e.g. `./data` for the data folder in the current directory)
  * Use 2 dots to go to the parent folder: `cd ..`

## Get the workshop files 📥

Use `git` to clone the repository

1. Open your terminal
2. Go to the directory where you want to store the workshop folder (using `cd my-folder/`)
3. Run:

```shell
git clone https://github.com/MaastrichtU-IDS/get-started-with-docker
```

> If you don't have `git` installed you can also [download the workshop as a `.zip` file](https://github.com/MaastrichtU-IDS/get-started-with-docker/archive/master.zip) and unzip it.

4. **Go the workshop folder in your terminal**:

```shell
cd get-started-with-docker
```

> For the whole workshop we assume you are running the terminal commands from this directory.

## Task 1: Find and start a database container 🔎

We want to start the [OpenLink Virtuoso database](http://vos.openlinksw.com/owiki/wiki/VOS) (a triplestore for RDF data) without loosing time installing all the required packages and setting up the configuration. 

We will then use a Docker container:

1. 🔎 Search for [**"virtuoso docker" on Google**](https://www.google.com/search?q=virtuoso+docker) (or your favorite search engine).

2. Various image will be found. Here is a few advices to pick the right Docker image for a service:

    * Check for a recent image that seems to be kept up-to-date, with an active community, or company behind if possible
    * Check the number of downloads to see how popular it is
    * You can also check how the application is installed in the `Dockerfile` (when source code available)
    * Note that currently most existing images are available on DockerHub, but things are changing. Using an image from a different registry does not change anything else than the start of the Image name (quay.io, ghcr.io...)

3. 👨‍💻 Follow the instructions from [tenforce/virtuoso](https://hub.docker.com/r/tenforce/virtuoso/) to start the Virtuoso triplestore using the `docker run` command. You will just need to change the shared volume:

    * They defined `-v /my/path/to/the/virtuoso/db:/data`

    * Change it to the `data/virtuoso` folder in your current directory, the path on the left of the `:` is for your computer, the path on the right is where the volume is shared in the container.

    * To provide the current directory as shared volume with the docker container the variable to use is different for Windows:
      * For Linux and Mac (use `\` at the end if you are using a command defined on multiple lines):

      ```shell
      -v $(pwd)/data/virtuoso:/data
      ```

      * For Windows, remove all the newlines with their extra `\`, and use:

      ```powershell
      -v ${PWD}/data/virtuoso:/data
      ```

👨‍💻 Access the Virtuoso triplestore on http://localhost:8890 (admin login: `dba` / `dba`)

> You can also check how Virtuoso is installed in the image [Dockerfile](https://github.com/tenforce/docker-virtuoso/blob/master/Dockerfile)

## Task 2: Start the container with docker-compose 📋

Open the `docker-compose.yml` file provided in the workshop folder with your favorite IDE (we recommend VisualStudio Code if you don't know which one to use)

Follow [tenforce/virtuoso](https://hub.docker.com/r/tenforce/virtuoso/) instructions to define a `docker-compose.yml` file to run Virtuoso, and make some changes:

* Define a fixed container name: `container_name: virtuoso` 
* Use the `latest` tag of the image: `tenforce/virtuoso:latest`
* Set the `DBA_PASSWORD` environment variable to `dba`
* Change the `DEFAULT_GRAPH` to https://w3id.org/um/ids/graph

> N.B.: In the `docker-compose.yml` file we use the current directory of the yml file to store the container data, use `.` at the start of the volume path:
>
> ```yaml
>     volumes:
>       - ./data/virtuoso:/data
> ```

👨‍💻 Start the containers defined in the `docker-compose.yml` file from your terminal:

```shell
docker-compose up
```

You can check running Docker containers on your laptop via the Docker Desktop UI or running this command in the terminal:

```shell
docker ps
```

> Try to access the Virtuoso triplestore running on http://localhost:8890

Stop the docker-compose running in your terminal by hitting the keys `ctrl + C`

👨‍💻 Run the containers detached from your terminal (in the background):

```shell
docker-compose up -d
```

👨‍💻 Check the logs of the running containers:

```shell
docker-compose logs
```

👨‍💻 Stop the running containers:

```shell
docker-compose down
```

## Task 3: Add a JupyterLab to the docker-compose 🔬

We will **add a JupyterLab to the docker-compose**, and use it to query the Virtuoso triplestore.

We will use a JupyterLab image with SPARQL libraries hosted on the [MaastrichU-IDS GitHub Container Registry](https://github.com/orgs/MaastrichtU-IDS/packages/container/package/jupyterlab-on-openshift).

1. Add the `jupyterlab` service to your `docker-compose.yml` (be careful with the indentation, it is meaninful):

```yaml
  jupyterlab:
    container_name: jupyterlab
    image: ghcr.io/maastrichtu-ids/jupyterlab-on-openshift
    environment:
      - JUPYTER_TOKEN=dba
      - JUPYTER_ENABLE_LAB=yes
```

2. 👨‍💻 You will need to add:

    * The Jupyter notebooks port used by the image: `8888:8888` 
    * The shared volume on `./data/jupyterlab:/home/jovyan`

> ⚠️ The official Jupyter Docker image uses the `jovyan` user by default which does not have admin rights (`sudo`). This can cause issues when writing to the shared volumes, to fix it you can change the owner of the folder or start JupyterLab as root user.

3. Create the folder with the right permissions before starting the containers:

You can create the folder you will use to store JupyterLab data, and define the right permissions, before running the JupyterLab container:

```shell
sudo mkdir -p data/jupyterlab
sudo chown -R 1000:1000 data/jupyterlab
```

4. Start JupyterLab and Virtuoso:

```shell
docker-compose up
```

Access JupyterLab on http://localhost:8888 (use `dba` as password) and Virtuoso on http://localhost:8890

> ⚠️ If you are still experiencing issue with the folder permissions (e.g. impossible to create or save a file in JupyterLab) remove the volume from JupyterLab and it will use an ephemeral storage that disappear when the container is deleted.

5. Query the Virtuoso database from the JupyterLab container
   
   * Create a **SPARQL notebook**
   
   * Create a cell to define the triplestore SPARQL endpoint URL:
   
     ```SPARQL
     %endpoint http://db:8890/sparql
     SELECT * WHERE {
         ?s ?p ?o .
     } LIMIT 10
     ```
   
   * Now **run the cell** to query the triplestore from the notebook 🚀

> By default `docker-compose` will create a network so that the services can access each other using their service identifier as URL without the need to expose the ports. 
>
> 💡 This allows you to easily deploy a public application on top of a hidden database.

## Task 4: Run JupyterLab with admin rights 🔓

You can also run JupyterLab with the `root` user to have admin rights

> 👨‍💻 Stop the previously ran Jupyterlab container (`ctrl + C` or `docker-compose down`)
>

We will now change the `docker-compose.yml` to start JupyterLab with the root user.

👨‍💻 Add the following parameters at the right place in the `docker-compose.yml`:

```yaml
services:
  jupyterlab:
    user: root
    environment:
      - GRANT_SUDO=yes
```

👨‍💻 Restart JupyterLab and Virtuoso:

```shell
docker-compose up --force-recreate
```

1. You should now be able to install anything in the JupyterLab container. Open a terminal in JupyterLab and try to update the packages: `apt update`  will fail due to lack of permission, use `sudo`

   ```shell
   sudo apt update
   ```

2. Create again a **SPARQL notebook** in the [JupyterLab](http://localhost:8888) to query the [SPARQL endpoint](http://localhost:8890):

   ```SPARQL
   %endpoint http://db:8890/sparql
   SELECT * WHERE {
       ?s ?p ?o .
   } LIMIT 10
   ```


## Task 5: Customize the Dockerfile 📦

We will improve the `Dockerfile` of the JupyterLab container to have a custom image with additional packages installed.

> See the [GitHub repository for the JupyterLab image](https://github.com/MaastrichtU-IDS/jupyterlab-on-openshift/).

Use the `Dockerfile` provided in the workshop folder to define your image.

We start from the JupyterLab image we were previously using:

```dockerfile
FROM ghcr.io/maastrichtu-ids/jupyterlab-on-openshift
```

👨‍💻 You will need to:

1. Change the user to `root` (to have admin rights by default)

2. Install the python package `rdflib` with `pip install` (💡 bonus: you can use the `requirements.txt` file to install the `rdflib` package in the container)


3. Go in the `docker-compose.yml` to build the container from the local `Dockerfile`, instead of using an existing image:

```yaml
services:
  jupyterlab:
    # image: ghcr.io/maastrichtu-ids/jupyterlab-on-openshift
    build: .
```

👨‍💻 Build and restart JupyterLab:

```shell
docker-compose up --build
```

You can also build the image using the `docker` command:

```shell
docker build -t my-jupyterlab .
```

## Checkout the solution ✔️

Go in the [`solution` folder](https://github.com/MaastrichtU-IDS/get-started-with-docker/tree/main/solution) to check the solution:

* `README.md` to run Virtuoso with `docker run` command, and solution guidelines
* `docker-compose.yml` with root JupyterLab and Virtuoso
* `Dockerfile` with root user and additional packages installed

## Login to Docker Registries 🔑

It is recommended to login to existing Container Registries if you have a user on their platform (e.g. DockerHub, GitHub), it will enable higher download limitations and rates! 🏆

### DockerHub

1. Get a [DockerHub](https://hub.docker.com/) account at https://hub.docker.com (you most probably already have one if you installed Docker Desktop)

2. Run in your terminal:

```bash
docker login
```

3. Provide DockerHub username and password

### GitHub Container Registry

Use your existing [GitHub](https://github.com) account if you have one:

1. Create a **Personal Access Token** for GitHub packages at https://github.com/settings/tokens/new
1. Provide a meaningful description for the token, and enable the following scopes when creating the token:
    * `read:packages`: download container images from GitHub Container Registry
    * `write:packages`: publish container images to GitHub Container Registry
    * `delete:packages`: delete specified versions of private or public container images from GitHub Container Registry
1. You might want to store this token provided by GitHub in a safe place as you will not be able to retrieve it later (you can still delete it an create a new easily)
1. Login to the GitHub Container Registry in your terminal (change `USERNAME` and `ACCESS_TOKEN` to yours):

```bash
echo "ACCESS_TOKEN" | docker login ghcr.io -u USERNAME --password-stdin
```

> See the [official GitHub documentation](https://docs.github.com/en/free-pro-team@latest/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages).