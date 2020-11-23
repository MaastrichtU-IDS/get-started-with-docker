# Start from an existing JupyterLab image
FROM ghcr.io/maastrichtu-ids/jupyterlab-on-openshift

# Change user to root to install packages and avoid permission issues
USER root

# Install a package from pip
RUN pip install rdflib

## We could also install it from the requirements.txt file:
# Copu requirements.txt file in the container
ADD requirements.txt .
# Run pip install on the file in the container
RUN pip install -r requirements.txt

# N.B.: We don't need to redefine the entrypoint
# Entrypoint from the base image will be used