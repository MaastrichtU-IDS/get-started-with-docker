# Define the base image
FROM ghcr.io/maastrichtu-ids/jupyterlab-on-openshift

# Add all files in the same folder as the Dockerfile in the built container
ADD . .

# Change the user in the container
USER username_or_userid

# Run a bash command
RUN my-command

# Define the entrypoint when the container is started
ENTRYPOINT [ "executable" ]

# Optionally you can provide default arguments 
# if no args are provided by the user at docker run
CMD [ "default" "arguments" ]
