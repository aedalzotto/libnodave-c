VERSION = 0.8.5.1
TARGET = libnodave.so

CC = gcc
CP = cp
MK = mkdir
RM = rm

SRCDIR = src
INCDIR 	 := $(SRCDIR)/include
TMP32 = tmp32
TMP64 = tmp64
DISTDIR = libnodave-$(VERSION)

SRCEXT  = c
SOURCES = $(wildcard $(SRCDIR)/*.$(SRCEXT))
HEADERS = $(wildcard $(INCDIR)/*.h)
OBJ64 = $(addprefix $(TMP64)/,$(notdir $(SOURCES:.$(SRCEXT)=.o)))
OBJ32 = $(addprefix $(TMP32)/,$(notdir $(SOURCES:.$(SRCEXT)=.o)))
INCHDR = $(addprefix $(DISTDIR)/include/,$(notdir $(HEADERS)))

CFLAGS = -Wall -DLINUX -DDAVE_LITTLE_ENDIAN -fPIC
LDFLAGS = -shared
INCLUDES := -I./$(INCDIR)

dist: $(DISTDIR)/lib/$(TARGET) $(DISTDIR)/lib32/$(TARGET) $(INCHDR)

$(DISTDIR)/lib/$(TARGET): $(OBJ64)
	@echo Linking libnodave.so x86-64
	@$(MK) -p $(DISTDIR)/lib
	$(CC) $^ -o $@ $(LDFLAGS)

$(TMP64)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@echo "Compiling $<..."
	@$(MK) -p $(TMP64)
	$(CC) -c $< -o $@ $(CFLAGS) $(INCLUDES)

$(DISTDIR)/lib32/$(TARGET): $(OBJ32)
	@echo Linking libnodave.so x86
	@$(MK) -p $(DISTDIR)/lib32
	$(CC) $^ -o $@ $(LDFLAGS) -m32

$(TMP32)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@echo "Compiling $<..."
	@$(MK) -p $(TMP32)
	$(CC) -c $< -o $@ $(CFLAGS) $(INCLUDES) -m32

$(DISTDIR)/include/%: $(INCDIR)/% 
	@echo "Copying $< ..."
	@$(MK) -p $(DISTDIR)/include
	@$(CP) $< $@

install:
	@echo "Installing..."
	@$(CP) -r $(DISTDIR) /usr/local/

zshrc:
	@echo "Exporting env vars..."
	@echo -e "\nexport LIBNODAVE=/usr/local/libnodave-$(VERSION)" >> ~/.zshrc
	@echo "export CPATH=\$$CPATH:\$$LIBNODAVE/include" >> ~/.zshrc
	@echo "export LD_LIBRARY_PATH=\$$LD_LIBRARY_PATH:\$$LIBNODAVE/lib" >> ~/.zshrc
	@echo "export LD_LIBRARY_PATH=\$$LD_LIBRARY_PATH:\$$LIBNODAVE/lib32" >> ~/.zshrc
	@echo "export LIBRARY_PATH=\$$LIBRARY_PATH:\$$LIBNODAVE/lib32" >> ~/.zshrc
	@echo "export LIBRARY_PATH=\$$LIBRARY_PATH:\$$LIBNODAVE/lib" >> ~/.zshrc

bashrc:
	@echo "Exporting env vars..."
	@echo -e "\nexport LIBNODAVE=/usr/local/libnodave-$(VERSION)" >> ~/.bashrc
	@echo "export CPATH=\$$CPATH:\$$LIBNODAVE/include" >> ~/.bashrc
	@echo "export LD_LIBRARY_PATH=\$$LD_LIBRARY_PATH:\$$LIBNODAVE/lib" >> ~/.bashrc
	@echo "export LD_LIBRARY_PATH=\$$LD_LIBRARY_PATH:\$$LIBNODAVE/lib32" >> ~/.bashrc
	@echo "export LIBRARY_PATH=\$$LIBRARY_PATH:\$$LIBNODAVE/lib32" >> ~/.bashrc
	@echo "export LIBRARY_PATH=\$$LIBRARY_PATH:\$$LIBNODAVE/lib" >> ~/.bashrc

clean:
	@echo "Cleaning..."
	@$(RM) -rf $(TMP64) $(TMP32) $(DISTDIR)