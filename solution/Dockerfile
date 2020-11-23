FROM ghcr.io/maastrichtu-ids/jupyterlab-on-openshift

USER root

RUN pip install rdflib

# We could also install it from the requirements.txt file
ADD requirements.txt .
RUN pip install -r requirements.txt


RUN wget -O /opt/rmlmapper.jar https://github.com/RMLio/rmlmapper-java/releases/download/v4.9.0/rmlmapper.jar

# N.B.: We don't need to redefine the entrypoint