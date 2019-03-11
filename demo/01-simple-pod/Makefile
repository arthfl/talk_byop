.PHONY: all
all:
	mkdir container-a/rootfs
	docker export $$(docker create networking-alpine:v0.2) | tar -C container-a/rootfs -xvf -
	mkdir container-b/rootfs
	docker export $$(docker create networking-alpine:v0.2) | tar -C container-b/rootfs -xvf -

.PHONY: clean
clean:
	rm -rf container-a/rootfs
	rm -rf container-b/rootfs
