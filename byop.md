% Build your own Pod

# $ whoami

# What is a Pod?

* A pod is a group of one or more containers, with shared storage/network,
and a specification for how to run the containers

# What is a container?

* Containers are not a real thing (on Linux)
* They are an abstract concept to describe the usage of namespaces and cgroups to run
isolated processes

# Namespaces

# CGroups

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

