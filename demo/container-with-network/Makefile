.PHONY: all
all:
	mkdir rootfs
	docker export $$(docker create networking-alpine:v0.1) | tar -C rootfs -xvf -

.PHONY: clean
clean:
	rm -rf rootfs
