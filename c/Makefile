CFLAGS = -Wall -O2

ifeq ($(OS),Windows_NT)
EXEEXT = .exe
CFLAGS += -fopenmp -municode
endif

llamafu$(EXEEXT): main.c llamacli.c
	$(CC) -o $@ $(CFLAGS) $^ `pkg-config --cflags --libs glib-2.0`

llamacli.c: ../llama.fu ../llamacli.fu
	fut -o $@ -D OPENMP $^

clean:
	$(RM) llamafu$(EXEEXT) llamacli.c llamacli.h
