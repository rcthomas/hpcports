
include ../pkg_defs.make

# Package parameters

PKG_NAME = subversion

PKG_FORMAT = tar
PKG_TAR = subversion-$(PKG_VERSION).tar.bz2
PKG_TAR_FETCH = $(WGET) -O $(HPCP_POOL)/$(PKG_TAR) http://apache.spinellicreations.com/subversion/subversion-$(PKG_VERSION).tar.bz2
PKG_TAR_EXTRACT = $(BXTAR)

PKG_SRCDIR = subversion-$(PKG_VERSION)

PKG_BUILDDIR = $(PKG_SRCDIR)

PKG_PATCHES =


# rules for this package

pkg-prefetch :
	@echo "" > /dev/null


pkg-configure :
	@cd $(STAGE); \
	mkdir -p $(PKG_BUILDDIR); \
	cd $(PKG_BUILDDIR); \
	host=""; \
	if [ "x$(HPCP_CROSS_HOST)" != "x" ]; then \
		host="--host=$(HPCP_CROSS_HOST)"; \
	fi; \
	dyn=""; \
	if [ "x$(BUILD_DYNAMIC)" != "xTRUE" ]; then \
		dyn="--disable-shared"; \
	fi; \
	CC="$(CC)" CFLAGS="$(CFLAGS)" \
	CXX="$(CXX)" CXXFLAGS="$(CXXFLAGS)" \
	LDFLAGS="$(LDFLAGS) -L$(sqlite_PREFIX)/lib" LIBS="$(sqlite_LIBS_CC) $(LIBS)" \
	./configure $${dyn} $${host} \
	--with-apr=$(apr_PREFIX) \
	--with-apr-util=$(apr_util_PREFIX) \
	--with-serf=$(serf_PREFIX) \
	--prefix=$(HPCP_PREFIX)/$(PKG_NAME)-$(PKG_FULLVERSION)


pkg-build :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	$(MAKE)


pkg-install :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	$(MAKE) install


pkg-clean :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	$(MAKE) clean


# Include common package rules

include ../pkg.make



