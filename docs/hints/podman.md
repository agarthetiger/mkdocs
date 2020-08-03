May need sudo for these.

# fetch

* `podman search <name>` - Find (details of) container image <name> in the configured registry
* `podman pull <name>` - Download the image locally

# images

Naming convention - registry_name/user_name/image_name:tag

# run

* `podman run -it <name>:<tag> /bin/bash` - Run an instance of the named tagged container image using /bin/bash as the entry point.
* `podman exec -it <name> /bin/bash` - Connect to a running container instance and open a bash shell.

Use -d (daemon) to run in the background
Use --name to give the container a name
Use -i (interactive) to keep stdin open even if not attached
Use -t (terminal) to create a pseudo terminal
