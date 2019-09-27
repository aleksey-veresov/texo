# Debug mode:
# DEBUG   = yes

CC      = g++
LIB     = libtexo.a

CFLAGS  = -Wall
ifeq '$(DEBUG)' 'yes'
CFLAGS += -g -O0
else
CFLAGS += -O3
endif

SRC_DIR = src
SRC     = $(wildcard $(SRC_DIR)/*.cpp)
OBJ     = $(SRC:.cpp=.o)


default: $(LIB)

ifneq "clean" "$(MAKECMDGOALS)"
-include deps.mk
endif

deps.mk: $(SRC)
	$(CC) -MM $^ > $@

%.o: %.cpp %.h
	$(CC) $(CFLAGS) -c $< -o $@

$(LIB): $(OBJ)
	ar rcs $@ $^

clean:
	rm -f $(OBJ) $(LIB) deps.mk
