## Advanced task 3: Add official JupyterLab to the docker-compose 🔭

For this advanced workshop we will use a JupyterLab image built using the official [Jupyter/docker-stacks](https://github.com/jupyter/docker-stacks). It is using the `jovyan` user to be compatible with some container orchestrator security policies (such as OpenShift)

The image is hosted in the [GitHub Container Registry](https://github.com/orgs/MaastrichtU-IDS/packages/container/package/jupyterlab-on-openshift), and is defined in this GitHub repository: https://github.com/MaastrichtU-IDS/jupyterlab-on-openshit

1. 👩‍💻 Look into the JupyterLab Docker image documentation to find out how to deploy it with `docker-compose`

2. You will need to change (be careful with the indentation, it is meaningful in YAML files):

    * The mapping from the JupyterLab container port `8888` to your computer port `8080`. Use `8080:8888`
    * The shared volume to `./data/jupyterlab:/home/jovyan`
    
    > Notice that the path/port mappings between your local machine and the container are always defined on the same side of the `:`
    >
    > * On your **local machine: always on the left ⬅️**
    > * In the **container: always on the right ➡️**

3. 👩‍💻 To enable `root` user, add the following parameters at the right place in the `docker-compose.yml`:

   ```yaml
   services:
     jupyterlab:
       user: root
       environment:
         - GRANT_SUDO=yes
   ```
   
4. ⚠️ The official Jupyter Docker image uses the `jovyan` user by default which does not have admin rights (`sudo`)! This can cause issues when writing to the volumes shared on your computer. 

   You will need to create the folder to store JupyterLab data on your computer before running the JupyterLab container, and define the right permissions, before running the JupyterLab container. 

Here is the command for Linux and Mac:

```shell
sudo mkdir -p data/jupyterlab
sudo chown -R 1000:1000 data/jupyterlab
```

> The second command defines the right permissions for the folder.

On Windows: try to create the repository manually before (if you are not using WSL), or do not use a volume for the JupyterLab container in the `docker-compose.yml`

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

---


## Task 4: Customize the Dockerfile 📦

We will improve the `Dockerfile` of the JupyterLab container to have a custom image with additional packages installed.

To do so you can now go back to the main README to continue from **Task 4**!

> If you are interested to see how the official Jupyter notebook Docker image can be customized checkout this Dockerfile used to install the Java and SPARQL kernels: https://github.com/MaastrichtU-IDS/jupyterlab-on-openshift/blob/master/Dockerfile

