.PHONY: all
all:
	runc spec
	mkdir rootfs
	docker export $$(docker create alpine:latest) | tar -C rootfs -xvf -

.PHONY: clean
clean:
	rm -rf rootfs
	rm config.json
