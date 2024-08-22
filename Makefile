CC = gcc
CFLAGS = -Wall -ansi -pedantic -fPIC -shared -m64 -std=c++20 -lrt

LUA_DIR = ../include/lua/include
LUA_LIB = ../lib/lua
LUA_CFLAGS = -I$(LUA_DIR)
LUA_LIBS = -L../lib/lua -llua

all: libluaperf.so

libluaperf.so: xLuaProfiler.o
	cd src && $(CC) TraceTree.o TraceNode.o xLuaProfiler.o -o libluaperf.so $(CFLAGS) $(LUA_LIBS) && mv libluaperf.so ../

xLuaProfiler.o: TraceNode.o TraceTree.o
	cd src && $(CC) -c xLuaProfiler.cpp $(CFLAGS) $(LUA_CFLAGS)

TraceTree.o:
	cd src && $(CC) -c TraceTree.cpp $(CFLAGS) $(LUA_CFLAGS)

TraceNode.o:
	cd src && $(CC) -c TraceNode.cpp $(CFLAGS) $(LUA_CFLAGS)

clean:
	rm -f src/*.o libluaperf.so

