SWIFTFLAGS = -O
ifeq ($(OS),Windows_NT)
EXEEXT = .exe
SWIFTFLAGS += -Xlinker -noexp -Xlinker -noimplib
endif

llamafu$(EXEEXT): main.swift llamacli.swift
	swiftc -o $@ $(SWIFTFLAGS) $^

llamacli.swift: ../llama.fu ../llamacli.fu
	fut -o $@ $^

clean:
	$(RM) llamafu$(EXEEXT) llamacli.swift

.PHONY: clean
