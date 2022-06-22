# Podman and MacOS

Podman is intended as a drop-in replacement for the docker cli and has from the outset had a focus on security and not running anything as root. You can run podman on MacOS using podman-machine instead of needing VirtualBox. The new MacBooks use the M1 or M2 chips, which are based on arm64 chips. This means there is a bit more work to do in order to build images for amd64 architecture. 

A bit more Googling that I expected turned up [this handy thread on Reddit](https://www.reddit.com/r/devops/comments/ta6v7p/m1_mac_with_base_64_images/), which makes it easy to run multi-architecture builds on MacOS with Podman.

```shell
podman machine ssh
sudo -i
rpm-ostree install qemu-user-static
systemctl reboot
```

After that you should be able to build different architectures by passing the --platform flag to podman. No need to install or run buildx. 
