EXECUTABLE_NAME = swiftymocky
REPO = https://github.com/MakeAWishFoundation/SwiftyMocky
VERSION = 3.5.0

PREFIX = /usr/local
INSTALL_PATH = $(PREFIX)/bin/$(EXECUTABLE_NAME)
BUILD_PATH = .build/release/$(EXECUTABLE_NAME)
CURRENT_PATH = $(PWD)
RELEASE_TAR = $(REPO)/archive/$(VERSION).tar.gz

.PHONY: install build uninstall clean

install: build
	mkdir -p $(PREFIX)/bin
	cp -f $(BUILD_PATH) $(INSTALL_PATH)

build:
	swift build --disable-sandbox -c release

uninstall:
	rm -f $(INSTALL_PATH)

clean:
	rm -rf .build
