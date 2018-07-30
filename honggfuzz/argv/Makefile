libinit.so: init.o
	hfuzz-clang -shared -fPIC init.o ../work/honggfuzz-1.6/libhfuzz/libhfuzz.a -o libinit.so

init.o: init.c
	hfuzz-clang -fPIC -Wall -Werror -Wno-unused-variable -g -c init.c

clean:
	rm -f *.o *.so
