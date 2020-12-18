# Generic Makefile.  Read 'port.txt' in the documentation
# directory for the Makefile that is right for you  - Kahn

CC      = gcc
PROF    = 
DEBUG   = -g3
O_FLAGS = 
C_FLAGS = $(O_FLAGS) -O -Wall $(DEBUG) $(PROF)
L_FLAGS = -O -lcrypt $(O_FLAGS) $(DEBUG) $(PROF)

#IMC2 - Comment out to disable IMC2 support
IMC = 1

O_FILES = act_comm.o act_info.o act_move.o act_obj.o act_wiz.o comm.o const.o \
          db.o fight.o handler.o interp.o magic.o save.o ssm.o special.o update.o

ifdef IMC
   O_FILES := imc.o sha256.o $(O_FILES)
   C_FLAGS := $(C_FLAGS) -DIMC -DIMCMERC
endif

envy: $(O_FILES)
	rm -f envy
	#$(CC) $(L_FLAGS) -o envy $(O_FILES)
	$(CC) -o envy $(O_FILES) $(L_FLAGS)

.c.o: merc.h
	$(CC) -c $(C_FLAGS) $<

clean:
	rm -f *.o envy envy2
