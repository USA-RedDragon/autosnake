CC = g++
CFLAGS = -Wall -Werror

V = @

CDIR_DHT := libdht/
include libdht/Makefile

CDIR_LCD := liblcd/
include liblcd/Makefile

CDIR_RELAY := librelay/
include librelay/Makefile

all: autosnake

autosnake: $(CDIR_LCD)/liblcd.so $(CDIR_DHT)/libdht.so $(CDIR_RELAY)/librelay.so src/autosnake.cpp
	@echo + compile src/autosnake.cpp
	$(V)$(CC) $(CFLAGS) -lpthread -lpigpio -lwiringPi -llcd -lrelay -ldht -o $@ src/autosnake.cpp

clean:
	@echo + clean
	$(V)rm -rf *.o *.so autosnake
	$(V)rm -rf */*.o */*.so autosnake

install:
	@echo + installing autosnake to /usr/bin/autosnake
	$(V)cp autosnake /usr/bin/autosnake
	@echo + installing libraries to /usr/lib
	$(V)cp */*.so /usr/lib/
