#### Start of system configuration section ####

# use gcc or gcc-3.3

CC = gcc
LD = gcc
PROG = ml_bcrypt.so
CXX = gcc
CPP = gcc

# Compiler flags
# NOTE: add -g for debug, remove for release!
CPPFLAGS = -m32 -MD -Wall -I./
LDFLAGS = -fPIC -m32 -shared -Wl,-soname,$(PROG).1,-R./
LIBS = -lstdc++ -llua

#### End of system configuration section ####

#### Source and object files

SRC_LOCAL = $(wildcard ./*.cpp)
OBJ_LOCAL = $(patsubst %.cpp,%.o,$(SRC_LOCAL))
OBJS_BLOWFISH = $(wildcard ./lib/blowfish/*.o)
OBJS = $(OBJ_LOCAL) $(OBJS_BLOWFISH)
SRCS = $(SRC_LOCAL)
DEPS = $(patsubst %.o,%.d,$(OBJS))


#### Make rules

all : ml_base

ml_base : $(OBJS)
	$(CC) $(CPPFLAGS) $(LDFLAGS) -o $(PROG) $(OBJS) $(LIBS)

clean :
	@rm *.o
	@rm $(PROG)

-include $(DEPS)