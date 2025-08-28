ODINFLAGS :=

build: bin
	odin build src -out:bin/baldr $(ODINFLAGS)

run:
	odin run src $(ODINFLAGS)

bin:
	mkdir -p bin

clean:
	rm -rf bin

.PHONY: build run clean
