ODINFLAGS :=

build: bin
	odin build src -out:bin/baldr $(ODINFLAGS)

run: images
	odin run src $(ODINFLAGS) > images/$(shell date +%Y%m%d_%H%M%S).ppm

bin:
	mkdir -p bin

images:
	mkdir -p images

clean:
	rm -rf bin images

.PHONY: build run clean
