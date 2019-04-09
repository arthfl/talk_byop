% Build your own Pod

# $ whoami

* Florian Arthofer
* Cloud Platform Engineer @ Dynatrace
* `@arthfl` on GitHub, Twitter...etc

# Why?

* Understanding things on a very low level, helps you debugging the silly problems

# What is a container?

* Containers are just an abstract concept to describe the usage of namespaces and cgroups to run
isolated processes

# Namespaces

* What you see
* `man namespaces`

# CGroups

* What you can use
* `man cgroups`

# What is a Pod?

* The smallest deployable unit of computing in K8S
* A pod is a group of one or more containers, with shared storage/network,
and a specification for how to run the containers

# Toolbox

* `runc`: CLI tool that implements the OCI standard
    * Used by Docker, Cloud Foundry, Kubernetes...etc
* `iproute2`: default userspace utils for Linux networking
* (This is not the lowest level to create containers)

# Create a simple OCI container

* Create spec file with `runc spec`
```bash
$ runc spec
```

* Create root filesystem
```bash
$ mkdir rootfs
$ docker export $(docker create alpine:latest) | tar -C rootfs -xvf -
```

* Run it!
```bash
$ runc run thecontainer
```

# Where is my network?

* With our simple config, there is no network
* We have to set up everything ourself :-)

# Configure basic network

* Create a bridge
* Create a network namespace
* Patch container into bridge
* Tell container about network namespace

# A simple pod

* Same network setup
* Just put two containers in the same network namespace
* Both see the same interface and can use it alternatingly

# A pod with a shared "volume"

* Both containers have `/srv/somevolume`, which is a bind-mount to the hosts `/tmp/somevolume`
* They are now able to access and write the same files

# Conclusion

* I'm really glad somebody automated all of that already

# Questions?

* ?

# Sources

* `man namespaces`
* `man cgroups`
* `man capabilities`
* https://blog.jessfraz.com/ (General container crazyness)
* https://blog.selectel.com/managing-containers-runc/ (low-level container networking)
* http://blog.siphos.be/tag/capabilities/ (capabilites overview)
* https://medium.com/@saschagrunert/demystifying-containers-part-i-kernel-space-2c53d6979504
(nice low level intro)
