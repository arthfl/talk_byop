% Build your own Pod

# $ whoami

# Why?

* Because sometimes, reinventing the wheel, can teach you a lot about
how wheels are built.

# What is a container?

* Containers are an abstract concept to describe the usage of namespaces and cgroups to run
isolated processes

# What is a Pod?

* A pod is a group of one or more containers, with shared storage/network,
and a specification for how to run the containers

# Namespaces

* What you see
* `man namespaces`

# CGroups

* What you can use
* `man cgroups`

# What is runc?

* CLI tool that implements the OCI standard
* Used by Docker, Cloud Foundry, Kubernetes...etc

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
$ runc run sh
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

* Both containers in the pod have the same directory mounted
* They are now able to access and write the same files

# Sources

* `man namespaces`
* `man cgroups`
* `man capabilities`
* https://blog.jessfraz.com/ (General container crazyness)
* https://blog.selectel.com/managing-containers-runc/ (low-level container networking) 
