.PHONY: all
all:
	mkdir rootfs
	docker export $$(docker create networking-alpine:latest) | tar -C rootfs -xvf -

.PHONY: clean
clean:
	rm -rf rootfs
