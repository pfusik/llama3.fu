CXXFLAGS = -Wall -O2

ifeq ($(OS),Windows_NT)
EXEEXT = .exe
CXXFLAGS += -fopenmp -municode
endif

llamafu$(EXEEXT): main.cpp llamacli.cpp
	$(CXX) -o $@ $(CXXFLAGS) $^

llamacli.cpp: ../llama.fu ../llamacli.fu
	fut -o $@ -D OPENMP $^

clean:
	$(RM) llamafu$(EXEEXT) llamacli.cpp llamacli.hpp
