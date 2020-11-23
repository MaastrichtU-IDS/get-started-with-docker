# Get started with Docker containers 🐳

A workshop to get started with Docker in an hour 🕐 (hopefully).

During this workshop you will:

* Find and run a Docker image for a database service (a Virtuoso triplestore for RDF data)
* Define a `docker-compose.yml` file to run a JupyterLab container alongside the database
* Run the JupyterLab container as restricted or admin user
* Customize an existing image by installing new packages and changing the user (JupyterLab)

Prerequisites:

* [Docker](https://docs.docker.com/get-docker/) installed
  * If you use Windows 🏢, we recommend you to use Docker with [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
  * If you use Linux 🐧, you will need to make sure you have also [`docker-compose` installed](https://docs.docker.com/compose/install/)
* Really basic knowledge of how to use the terminal:
  * **L**i**s**t files in current directory: `ls`
  * Find the **p**ath to the (current) **w**orking **d**irectory: `pwd`
  * **C**hange **d**irectory: `cd subfolder` or `cd ../parent-folder`
  * When defining a path, the dot `.` defines the current directory, it is usually used at the start of the path, e.g. `./data` for the data folder in the current directory)
  * N.B.: folder and directory usually means the same thing.

## Table of content
   * [Get started with Docker containers <g-emoji class="g-emoji" alias="whale" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f433.png">🐳</g-emoji>](#get-started-with-docker-containers-)
      * [Table of content](#table-of-content)
      * [Get the workshop files <g-emoji class="g-emoji" alias="inbox_tray" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f4e5.png">📥</g-emoji>](#get-the-workshop-files-)
      * [Task 1: Find and start a database container <g-emoji class="g-emoji" alias="mag_right" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f50e.png">🔎</g-emoji>](#task-1-find-and-start-a-database-container-)
      * [Task 2: Start the container with a docker-compose file <g-emoji class="g-emoji" alias="clipboard" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f4cb.png">📋</g-emoji>](#task-2-start-the-container-with-a-docker-compose-file-)
      * [Task 3: Add a JupyterLab to the docker-compose <g-emoji class="g-emoji" alias="microscope" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f52c.png">🔬</g-emoji>](#task-3-add-a-jupyterlab-to-the-docker-compose-)
      * [Task 4: Run JupyterLab with admin rights <g-emoji class="g-emoji" alias="unlock" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f513.png">🔓</g-emoji>](#task-4-run-jupyterlab-with-admin-rights-)
      * [Task 5: Customize the Dockerfile <g-emoji class="g-emoji" alias="package" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f4e6.png">📦</g-emoji>](#task-5-customize-the-dockerfile-)
      * [Task 6: Login to Container Registries <g-emoji class="g-emoji" alias="key" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f511.png">🔑</g-emoji>](#task-6-login-to-container-registries-)
         * [DockerHub](#dockerhub)
         * [GitHub Container Registry](#github-container-registry)
      * [Bonus: Publish your image <g-emoji class="g-emoji" alias="loudspeaker" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f4e2.png">📢</g-emoji>](#bonus-publish-your-image-)
         * [Publish to GitHub Container Registry](#publish-to-github-container-registry)
         * [Publish to DockerHub](#publish-to-dockerhub)
         * [Use automated workflows](#use-automated-workflows)
      * [Checkout the solution <g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png">✔️</g-emoji>](#checkout-the-solution-\xEF\xB8\x8F)

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

    * Check for a **recent image** that seems to be kept up-to-date, with an active community, or company behind if possible
    * Check the number of **Pulls** (downloads) to see how popular it is
    * You can also check how the application is installed in the `Dockerfile` (when source code available)
    * Note that currently most existing images are available on DockerHub, but things are changing (quay.io, ghcr.io...). Thankfully, using an image from a different registry does not change anything else than the image name!

3. 👩‍💻 Follow the instructions for the [tenforce/virtuoso](https://hub.docker.com/r/tenforce/virtuoso/) image (https://hub.docker.com/r/tenforce/virtuoso), to start the Virtuoso triplestore using the `docker run` command. You will just need to change the shared volume:

    * They defined `-v /my/path/to/the/virtuoso/db:/data`. Change it to the `data/virtuoso` folder in your current directory, the path on the left of the `:` is for your computer, the path on the right is where the volume is shared in the container.

    * To provide the current directory as shared volume with the docker container the variable to use is different for Windows:
  * For Linux 🐧 and Mac 🍎
    
    ```shell
    -v $(pwd)/data/virtuoso:/data
    ```
    
      * For Windows 🏢 (remove all the newlines with their extra `\` to have one line):

    ```powershell
    -v ${PWD}/data/virtuoso:/data
    ```

👨‍💻 Access the Virtuoso triplestore on http://localhost:8890 (admin login: `dba` / `dba`)

> You can also check how Virtuoso is installed in the image [Dockerfile](https://github.com/tenforce/docker-virtuoso/blob/master/Dockerfile)

## Task 2: Start the container with a docker-compose file 📋

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

👩‍💻 Start the containers defined in the `docker-compose.yml` file from your terminal:

```shell
docker-compose up
```

You can check running Docker containers on your laptop via the Docker Desktop UI or running this command in the terminal:

```shell
docker ps
```

> Try to access the Virtuoso triplestore running on http://localhost:8890

Stop the docker-compose running in your terminal by hitting the keys `ctrl + c`

👨‍💻 Run the containers detached from your terminal (in the background):

```shell
docker-compose up -d
```

👩‍💻 Check the logs of the running containers:

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

2. 👩‍💻 You will need to add:

    * Mapping from the JupyterLab container port `8888` to your computer port `8080`. Use `8080:8888`
    * The shared volume on `./data/jupyterlab:/home/jovyan`

> ⚠️ The official Jupyter Docker image uses the `jovyan` user by default which does not have admin rights (`sudo`). This can cause issues when writing to the shared volumes, to fix it you can change the owner of the folder or start JupyterLab as root user.

3. Create the folder with the right permissions before starting the containers!

You need to create the folder you will use to store JupyterLab data, and define the right permissions, before running the JupyterLab container. Here is the command for Linux and Mac:

```shell
sudo mkdir -p data/jupyterlab
sudo chown -R 1000:1000 data/jupyterlab
```

4. Start JupyterLab and Virtuoso:

```shell
docker-compose up
```

Access JupyterLab on http://localhost:8888 (use `dba` as password) and Virtuoso on http://localhost:8890

> ⚠️ If you are experiencing issue with the folder permissions: **remove the volume of the JupyterLab container in the `docker-compose.yml`**
>
> Docker will use an ephemeral storage that disappear when the container is deleted.

5. Query the Virtuoso database from the JupyterLab container
   
   * Create a new **SPARQL Notebook** in JupyterLab
   
   * Create a cell to run a SPARQL query on the Virtuoso triplestore SPARQL endpoint:
   
     ```SPARQL
     %endpoint http://db:8890/sparql
     SELECT * WHERE {
         ?s ?p ?o .
     } LIMIT 10
     ```
   
   * Now **run the cell** to query the triplestore from the notebook 🚀

> By default `docker-compose` will create a network so that the services can access each other using their service identifier from the YAML as URL without the need to expose the ports. 
>
> 💡 This allows you to easily deploy a public application on top of a hidden database.

## Task 4: Run JupyterLab with admin rights 🔓

You can also run JupyterLab with the `root` user to have admin rights

> 👨‍💻 Stop the previously ran Jupyterlab container (`ctrl + c` or `docker-compose down`)
>

We will now change the `docker-compose.yml` to start JupyterLab with the root user.

👩‍💻 Add the following parameters at the right place in the `docker-compose.yml`:

```yaml
services:
  jupyterlab:
    user: root
    environment:
      - GRANT_SUDO=yes
```

👨‍💻 Restart JupyterLab and Virtuoso from the terminal:

```shell
docker-compose up --force-recreate
```

1. You should now be able to install anything in the JupyterLab container. Open a terminal in the [JupyterLab web UI](http://localhost:8888/), and try to update the packages. Running `apt update`  will fail due to lack of permission, use `sudo`:

   ```shell
   sudo apt update
   ```

2. Create again a **SPARQL notebook** in the [JupyterLab](http://localhost:8888) to check querying the [SPARQL endpoint](http://localhost:8890) works:

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

It will start from the JupyterLab image we were previously using:

```dockerfile
FROM ghcr.io/maastrichtu-ids/jupyterlab-on-openshift
```

👩‍💻 In the `Dockerfile`, you will need to:

1. Change the user to `root` (to have admin rights by default)

2. Install the python package `rdflib` with `pip install` (💡 bonus: you can use the `requirements.txt` file to install the `rdflib` package in the container)


3. Go in the `docker-compose.yml` to build the container from the local `Dockerfile`, instead of using an existing image:

```yaml
services:
  jupyterlab:
    # image: ghcr.io/maastrichtu-ids/jupyterlab-on-openshift
    build: .
```

👨‍💻 Build and restart JupyterLab from the terminal:

```shell
docker-compose up --build
```

You can also build the image using the `docker` command:

```shell
docker build -t my-jupyterlab .
```

## Task 6: Login to Container Registries 🔑

It is recommended to login to existing Container Registries if you have a user on their platform (e.g. DockerHub, GitHub), it will enable higher download limitations and rates! 🏆

### DockerHub

1. Get a [DockerHub](https://hub.docker.com/) account at https://hub.docker.com (you most probably already have one if you installed Docker Desktop)

2. 👩‍💻 Run in your terminal:

```bash
docker login
```

3. Provide your DockerHub username and password.

### GitHub Container Registry

Use your existing [GitHub](https://github.com) account if you have one:

1. Create a **Personal Access Token** for GitHub packages at **https://github.com/settings/tokens/new**
1. Provide a meaningful description for the token, and enable the following scopes when creating the token:
    * `read:packages`: download container images from GitHub Container Registry
    * `write:packages`: publish container images to GitHub Container Registry
    * `delete:packages`: delete specified versions of private or public container images from GitHub Container Registry
1. You might want to store this token in a safe place, as you will not be able to retrieve it later (you can still delete it, and create a new token easily)
1. 👨‍💻 Login to the GitHub Container Registry in your terminal (change `USERNAME` and `ACCESS_TOKEN` to yours):

```bash
echo "ACCESS_TOKEN" | docker login ghcr.io -u USERNAME --password-stdin
```

> See the [official GitHub documentation](https://docs.github.com/en/free-pro-team@latest/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages).

## Bonus: Publish your image 📢

Once you built a Docker image you might want to publish it to pull it, and re-use it easily later.

### Publish to GitHub Container Registry

The [GitHub Container Registry](https://docs.github.com/en/free-pro-team@latest/packages/getting-started-with-github-container-registry) is still in beta, but will be free for public images. And it enables you to store your images at the same place you store your code.

Publish to your GitHub user registry:

```bash
docker build -t ghcr.io/github-username/jupyterlab:latest .
docker push ghcr.io/github-username/jupyterlab:latest
```

Or to the [MaastrichtU-IDS GitHub Container Registry](https://github.com/orgs/MaastrichtU-IDS/packages):

```bash
docker build -t ghcr.io/maastrichtu-ids/jupyterlab-on-openshift:latest .
docker push ghcr.io/maastrichtu-ids/jupyterlab-on-openshift:latest
```

### Publish to DockerHub

[DockerHub](https://hub.docker.com/) is still the most popular and mature Container Registry, and the new rates should not impact a regular user.

First create the repository on [DockerHub](https://hub.docker.com/) (attached to your user or an [organization](https://hub.docker.com/orgs/umids/repositories)), then build and push the image:

```bash
docker build -t dockerhub-username/jupyterlab:latest .
docker push dockerhub-username/jupyterlab:latest
```

> You can also change the name of an existing image:
>
> ```bash
> docker build -t my-jupyterlab .
> docker tag my-jupyterlab ghcr.io/github-username/jupyterlab:latest
> ```

### Use automated workflows

You can automate the building and publication of Docker images using GitHub Actions workflows 🔄

👀 Check the [`.github/workflows/publish-docker.yml` file](https://github.com/MaastrichtU-IDS/get-started-with-docker/blob/main/.github/workflows/publish-docker.yml) to see an example of a workflow to publish an image to the GitHub Container Registry.

👩‍💻 You just need to change the `IMAGE_NAME`, and use it in your GitHub repository to publish a Docker image for your application automatically! It will build from a `Dockerfile` at the root of the repository.

The workflow can be easily configured to:

* publish a new image to the `latest` tag at each push to the main branch
* publish an image to a new tag if a release is pushed on GitHub (using the git tag)
  * e.g. `v0.0.1` published as image `0.0.1`

> If you publish your image on DockerHub, you can use [automated build on DockerHub](https://docs.docker.com/docker-hub/builds/).

> GitHub Actions is still currently evolving quickly, feel free to check if they recommend new way to build and publish containers 🚀

## Checkout the solution ✔️

Go in the [`solution` folder](https://github.com/MaastrichtU-IDS/get-started-with-docker/tree/main/solution) to check the solution:

* `README.md` for the general solution guidelines, and to run Virtuoso with the `docker run` command
* `Dockerfile` with root user and additional packages installed
* `docker-compose.yml` to build and run custom JupyterLab and Virtuoso database