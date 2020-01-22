.PHONY: all
all:
	mkdir rootfs
	docker export $$(docker create arthfl/networking-alpine:latest) | tar -C rootfs -xvf -

.PHONY: clean
clean:
	rm -rf rootfs
