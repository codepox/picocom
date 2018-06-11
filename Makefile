
VERSION=1.7+

UUCP_LOCK_DIR=/var/lock

# CC = gcc
CPPFLAGS=-DVERSION_STR=\"$(VERSION)\" \
         -DUUCP_LOCK_DIR=\"$(UUCP_LOCK_DIR)\" \
         -DHIGH_BAUD
CFLAGS = -Wall -g

# LD = gcc
LDFLAGS = -g
LDLIBS =

SRCS=picocom.c term.c split.c
OBJS=$(SRCS:.c=.o)

picocom : picocom.o term.o split.o
#	$(LD) $(LDFLAGS) -o $@ $+ $(LDLIBS)

picocom.o : picocom.c term.h
term.o : term.c term.h
split.o : split.c split.h

doc : picocom.8 picocom.8.html picocom.8.ps

changes : 
	svn log -v . > CHANGES

picocom.8 : picocom.8.xml
	xmlmp2man < $< > $@

picocom.8.html : picocom.8.xml
	xmlmp2html < $< > $@

picocom.8.ps : picocom.8
	groff -mandoc -Tps $< > $@

clean:
#	rm -f picocom.o term.o
	rm -f $(OBJS)
	rm -f *~
	rm -f \#*\#

distclean: clean
	rm -f picocom

realclean: distclean
	rm -f picocom.8
	rm -f picocom.8.html
	rm -f picocom.8.ps
	rm -f CHANGES
