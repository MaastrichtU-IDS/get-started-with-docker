# Define the base image
FROM ghcr.io/maastrichtu-ids/jupyterlab-on-openshift

# Add files in the same folder as the Dockerfile to the container
# Only use it if you need it
ADD . .

# Change the user in the container if you need to
USER username_or_userid

# Run a bash command
RUN my-command

# Optional: define the entrypoint when the container is started
# Entrypoint from the base image will be used if not provided
ENTRYPOINT [ "executable" ]

# Optionally you can provide default arguments 
# if no args are provided by the user at docker run
CMD [ "default" "arguments" ]
