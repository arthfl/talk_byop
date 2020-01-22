.PHONY: all
all:
	mkdir container-a/rootfs
	docker export $$(docker create arthfl/networking-alpine:latest) | tar -C container-a/rootfs -xvf -
	mkdir container-b/rootfs
	docker export $$(docker create arthfl/networking-alpine:latest) | tar -C container-b/rootfs -xvf -
	mkdir /tmp/somevolume

.PHONY: clean
clean:
	rm -rf container-a/rootfs
	rm -rf container-b/rootfs
	rm -rf /tmp/somevolume
