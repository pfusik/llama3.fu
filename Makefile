CFLAGS = -Wall -O2

ifeq ($(OS),Windows_NT)
EXEEXT = .exe
endif

all: c cpp cs d java js py ts

c cpp java js py ts:
	$(MAKE) -C $@

cs:
	dotnet build cs -c Release

d:
	dub build --root=d -b release

float2bf16$(EXEEXT): float2bf16.c
	$(CC) -o $@ $(CFLAGS) $^

.PHONY: c cpp cs d java js py ts
