# Get started with Docker containers 🐳

A workshop to get started with Docker in an hour 🕐 (hopefully)!

During this workshop, you will:

* Find and run a Docker image for a database service (a Virtuoso triplestore for RDF data)
* Define a `docker-compose.yml` file to run a JupyterLab container alongside the database
* Customize an existing image by installing new packages and changing the user (JupyterLab)
* Login to DockerHub and GitHub Container Registry.

Prerequisites:

* [Docker](https://docs.docker.com/get-docker/) installed
  
  * If you use Windows 🏢, we recommend you to use Docker with [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
  * If you use Linux 🐧, you will need to make sure you have also [`docker-compose` installed](https://docs.docker.com/compose/install/)
  
* Fundamental knowledge of how to navigate in the terminal ⌨️
  1. **L**i**s**t files in current directory: `ls`
  2. Find the **P**ath to the (current) **W**orking **D**irectory: `pwd`
  3. **C**hange **D**irectory: `cd subfolder` or `cd ../parent-folder`
  4. Use the `tab` key in your terminal to get recommendations for potential command arguments (later [install ZSH](https://ohmyz.sh/) for a better experience in the computer terminal)

  > When defining a path, the dot `.` represents the current directory, it is usually used at the start of the path, e.g. `./data` for the data folder in the current directory)
  >
  > N.B.: folder and directory usually mean the same thing.

## Table of Content 🧭

* [Get the workshop files <g-emoji class="g-emoji" alias="inbox_tray" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f4e5.png">📥</g-emoji>](#get-the-workshop-files-)
* [Task 1: Find and start a database container <g-emoji class="g-emoji" alias="mag_right" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f50e.png">🔎</g-emoji>](#task-1-find-and-start-a-database-container-)
* [Task 2: Start the database container with a docker-compose file <g-emoji class="g-emoji" alias="clipboard" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f4cb.png">📋</g-emoji>](#task-2-start-the-database-container-with-a-docker-compose-file-)
* [Task 3: Add JupyterLab to the docker-compose <g-emoji class="g-emoji" alias="telescope" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f52d.png">🔭</g-emoji>](#task-3-add-jupyterlab-to-the-docker-compose-)
* [Task 4: Customize the Docker image <g-emoji class="g-emoji" alias="package" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f4e6.png">📦</g-emoji>](#task-4-customize-the-docker-image-)
* [Task 5: Login to Container Registries <g-emoji class="g-emoji" alias="key" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f511.png">🔑</g-emoji>](#task-5-login-to-container-registries-)
    * [Login to DockerHub](#login-to-dockerhub)
    * [Login to GitHub Container Registry](#login-to-github-container-registry)
* [Bonus: Publish your image <g-emoji class="g-emoji" alias="loudspeaker" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f4e2.png">📢</g-emoji>](#bonus-publish-your-image-)
    * [Publish to GitHub Container Registry](#publish-to-github-container-registry)
    * [Publish to DockerHub](#publish-to-dockerhub)
    * [Use automated workflows](#use-automated-workflows)
* [Check the solution <g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png">✔️</g-emoji>](#use-automated-workflows)

## Get the workshop files 📥

Use `git` to clone the repository.

1. Open your terminal ⌨️
2. Go to the directory where you want to store the workshop folder (using `cd my-folder/`)
3. Clone the GitHub repository with this command:

```shell
git clone https://github.com/MaastrichtU-IDS/get-started-with-docker
```

> If you don't have `git` installed you can also [download the workshop as a `.zip` file](https://github.com/MaastrichtU-IDS/get-started-with-docker/archive/master.zip) and unzip it 🤐

4. **Go the workshop folder in your terminal**:

```shell
cd get-started-with-docker
```

> For the whole workshop we assume you are running the terminal commands from this directory.

---

## Task 1: Find and start a database container 🔎

We want to start the [OpenLink Virtuoso database](http://vos.openlinksw.com/owiki/wiki/VOS) (a triplestore for RDF data) without losing time installing all the required packages and setting up the configuration. 

We will then use a Docker container:

1. 🔎 Search for [**"virtuoso docker" on Google**](https://www.google.com/search?q=virtuoso+docker) (or your favourite search engine).

2. Different Docker images will be found. Here are a few bits of advice to pick the right Docker image for a service:

    * Check for a **recent image** that seems to be kept up-to-date, with an active community, or company behind if possible
    * Check the number of **Pulls** (downloads) to see how popular it is
    * You can also check how the application is installed in the `Dockerfile` (when source code available)
    * Note that currently, most existing images are available on DockerHub, but things are changing (quay.io, ghcr.io...). Thankfully, using an image from a different registry does not change anything else than the image name!

3. 👩‍💻 Follow the instructions for the [tenforce/virtuoso](https://hub.docker.com/r/tenforce/virtuoso/) image (https://hub.docker.com/r/tenforce/virtuoso), to start the Virtuoso triplestore using the `docker run` command. You will only need to change the shared volume:


* They defined `-v /my/path/to/the/virtuoso/db:/data`. Change it to the `data/virtuoso` folder in your current directory, the path on the left of the `:` is for your computer, the path on the right is where the volume is shared in the container.

* To provide the current directory as a shared volume with the docker container the variable to use is different for Windows:
  
    * For Linux 🐧 and Mac 🍎
    
      ```bash
      -v $(pwd)/data/virtuoso:/data
      ```
    
    * For Windows 🏢 (remove all the newlines with their extra `\` to have one line):
    
      ```powershell
      -v ${PWD}/data/virtuoso:/data
      ```

👨‍💻 Access the Virtuoso triplestore on http://localhost:8890 (admin login: `dba` / `dba`)

> You can also check how Virtuoso is installed in the image [Dockerfile](https://github.com/tenforce/docker-virtuoso/blob/master/Dockerfile)

---

## Task 2: Start the database container with a docker-compose file 📋

Open the `docker-compose.yml` file provided in the workshop folder with your favourite IDE (we recommend VisualStudio Code if you don't know which one to use)

Follow [tenforce/virtuoso](https://hub.docker.com/r/tenforce/virtuoso/) instructions to define a `docker-compose.yml` file to run Virtuoso, and make some changes:

* Define a fixed container name: `container_name: virtuoso` 
* Use the `latest` tag of the image: `tenforce/virtuoso:latest`
* Set the `DBA_PASSWORD` environment variable to `dba`
* Change the `DEFAULT_GRAPH` to https://w3id.org/um/ids/graph
* Keep the `volumes` as described in tenforce/virtuoso, the triplestore `/data` files will be shared on your computer in `./data/virtuoso`
  * N.B.: `docker-compose` uses `./` to define a volume path from the directory where the YAML file is stored

> ⚠️ Be careful with the indentation, it is meaningful in YAML files

👩‍💻 Start the containers defined in the `docker-compose.yml` file from your terminal:

```shell
docker-compose up
```

You can check running Docker containers on your laptop via the Docker Desktop U.I. or running this command in the terminal:

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

---

## Task 3: Add JupyterLab to the docker-compose 🔭

We want to run a JupyterLab to query our Virtuoso triplestore. 

* We could try to install locally the [IJava kernel](https://github.com/SpencerPark/IJava) and the [SPARQL kernel](https://github.com/paulovn/sparql-kernel), but it will take more time and will be prone to installation errors and conflicts ❌ (We already tried with our students in the bachelor program!)
* The easiest would be to start a JupyterLab Docker container with the 2 kernels pre-installed ✔️

🍀 Luckily there is already a Docker image with all those kernels installed! 

The image is hosted in the [GitHub Container Registry](https://github.com/users/vemonet/packages/container/package/jupyterlab), and is defined in this GitHub repository: https://github.com/vemonet/Jupyterlab

> If you are already comfortable with Docker, feel free to [try the advanced workshop using the official Jupyter Docker image](https://github.com/MaastrichtU-IDS/get-started-with-docker/tree/main/advanced). This workshop adds a new dimension to Docker deployment with managing files, permissions and owners.

1. 👩‍💻 Look into the JupyterLab Docker image documentation to find out how to deploy it with `docker-compose`

2. You will need to change (be careful with the indentation, it is meaningful in YAML files):

    * The mapping from the JupyterLab container port `8888` to your computer port `8080`. Use `8080:8888`
    * The shared volume to `./data/jupyterlab:/notebooks`
    
    > Notice that the path/port mappings between your local machine and the container are always defined on the same side of the `:`
    >
    > * On your **local machine: always on the left ⬅️**
    > * In the **container: always on the right ➡️**

3. Start JupyterLab and Virtuoso:

```shell
docker-compose up
```

Access JupyterLab on http://localhost:8888 and Virtuoso on http://localhost:8890

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
> 💡 This allows you to quickly deploy a public application with a database in the background.

---


## Task 4: Customize the Docker image 📦

We will improve the `Dockerfile` of the JupyterLab container to build a custom image with additional packages installed.

> Checkout the [Dockerfile of the JupyterLab image](https://github.com/vemonet/Jupyterlab/blob/main/Dockerfile) to see how a complete image can be built.

Open the `Dockerfile` provided in the workshop folder to define your image.

It will start from the JupyterLab image we were previously using:

```dockerfile
FROM ghcr.io/vemonet/jupyterlab
```

👩‍💻 Install the python package `rdflib` with `pip install` in the `Dockerfile` (💡 bonus: you can also use the `requirements.txt` file to install the `rdflib` package in the container)

👩‍💻 Change the `docker-compose.yml` to build the container from the local `Dockerfile`, instead of using an existing image:

```yaml
services:
  jupyterlab:
    # image: ghcr.io/vemonet/jupyterlab
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

---

## Task 5: Log in to Container Registries 🔑

It is recommended to login to existing Container Registries if you have a user on their platform (e.g. DockerHub, GitHub), it will enable higher download limitations and rates! 🏆

### Login to DockerHub

1. Get a [DockerHub](https://hub.docker.com/) account at https://hub.docker.com (you most probably already have one if you installed Docker Desktop)

2. 👩‍💻 Run in your terminal:

```bash
docker login
```

3. Provide your DockerHub username and password.

### Login to GitHub Container Registry

Use your existing [GitHub](https://github.com) account if you have one:

1. Create a **Personal Access Token** for GitHub packages at **https://github.com/settings/tokens/new**
1. Provide a meaningful description for the token, and enable the following scopes when creating the token:
    * `write:packages`: publish container images to GitHub Container Registry
    * `delete:packages`: delete specified versions of private or public container images from GitHub Container Registry
1. You might want to store this token in a safe place, as you will not be able to retrieve it later on github.com (you can still delete it, and create a new token easily if you lose your token)
1. 👨‍💻 Log in to the GitHub Container Registry in your terminal (change `USERNAME` and `ACCESS_TOKEN` to yours):

```bash
echo "ACCESS_TOKEN" | docker login ghcr.io -u USERNAME --password-stdin
```

> See the [official GitHub documentation](https://docs.github.com/en/free-pro-team@latest/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages).

---

## Bonus: Publish your image 📢

Once you built a Docker image, and you logged in to a Container Registry, you might want to publish the image to pull and re-use it easily later.

### Publish to GitHub Container Registry

The [GitHub Container Registry](https://docs.github.com/en/free-pro-team@latest/packages/getting-started-with-github-container-registry) is still in beta but will be free for public images when fully released. It enables you to store your Docker images at the same place you keep your code! 📦

Publish to your user Container Registry on GitHub:

```bash
docker build -t ghcr.io/github-username/jupyterlab:latest .
docker push ghcr.io/github-username/jupyterlab:latest
```

Or to the [MaastrichtU-IDS Container Registry on GitHub](https://github.com/orgs/MaastrichtU-IDS/packages):

```bash
docker build -t ghcr.io/vemonet/jupyterlab:latest .
docker push ghcr.io/vemonet/jupyterlab:latest
```

### Publish to DockerHub

[DockerHub](https://hub.docker.com/) is still the most popular and mature Container Registry, and the new rates should not impact a regular user.

First, create the repository on [DockerHub](https://hub.docker.com/) (attached to your user or an [organization](https://hub.docker.com/orgs/umids/repositories)), then build and push the image:

```bash
docker build -t dockerhub-username/jupyterlab:latest .
docker push dockerhub-username/jupyterlab:latest
```

> You can also change the name (aka. tag) of an existing image:
>
> ```bash
> docker build -t my-jupyterlab .
> docker tag my-jupyterlab ghcr.io/github-username/jupyterlab:latest
> ```

### Use automated workflows

You can automate the building and publication of Docker images using GitHub Actions workflows 🔄

👀 Check the [`.github/workflows/publish-docker.yml` file](https://github.com/MaastrichtU-IDS/get-started-with-docker/blob/main/.github/workflows/publish-docker.yml) to see an example of a workflow to publish an image to the GitHub Container Registry.

👩‍💻 You only need to change the `IMAGE_NAME`, and use it in your GitHub repository to publish a Docker image for your application automatically! It will build from a `Dockerfile` at the root of the repository.

The workflow can be easily configured to:

* publish a new image to the `latest` tag at each push to the main branch
* publish an image to a new tag if a release is pushed on GitHub (using the git tag)
  * e.g. `v0.0.1` published as image `0.0.1`

> If you publish your image on DockerHub, you can use [automated build on DockerHub](https://docs.docker.com/docker-hub/builds/).

> GitHub Actions is still currently evolving quickly, feel free to check if they recommend a new way to build and publish containers 🚀

---

## Check the solution ✔️

Go in the [`solution` folder](https://github.com/MaastrichtU-IDS/get-started-with-docker/tree/main/solution) to check the solution:

* `README.md` for the general solution guidelines, and to run Virtuoso with the `docker run` command
* `Dockerfile` with root user and additional packages installed for a custom JupyterLab image
* `docker-compose.yml` to build and run a custom JupyterLab container and a Virtuoso database
* `docker-compose.advanced.yml` to run the official JupyterLab container and a Virtuoso database

> See also, the previous docker-workshop provided by IDS: https://github.com/MaastrichtU-IDS/docker-workshop
