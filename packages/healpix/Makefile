
include ../pkg_defs.make

# Package parameters

PKG_NAME = healpix

PKG_FORMAT = tar
PKG_TAR = healpix-$(PKG_VERSION).tar.bz2
PKG_TAR_FETCH = 
PKG_TAR_EXTRACT = $(BXTAR)

PKG_SRCDIR = healpix-$(PKG_VERSION)

PKG_BUILDDIR = $(PKG_SRCDIR)

PKG_PATCHES =


# rules for this package

pkg-prefetch :
	@echo "" > /dev/null


pkg-configure :
	@cd $(STAGE)/$(PKG_BUILDDIR); \
	host=""; \
	if [ "x$(HPCP_CROSS_HOST)" != "x" ]; then \
		host="--host=$(HPCP_CROSS_HOST)"; \
	fi; \
	dyn="--disable-shared --enable-static --enable-all-static"; \
	if [ "x$(BUILD_DYNAMIC)" = "xTRUE" ]; then \
		dyn="--enable-shared"; \
	fi; \
	CC="$(CC)" CFLAGS="$(CFLAGS)" \
	CXX="$(CXX)" CXXFLAGS="$(CXXFLAGS)" \
	FC="$(FC)" FCFLAGS="$(FCFLAGS)" \
	FCLIBS="$(FCLIBS)" MPIFCLIBS="$(MPIFCLIBS)" \
	MPICC="$(MPICC)" MPIFC="$(MPIFC)" MPICXX="$(MPICXX)" \
	IDL="idl" \
	./configure $${dyn} $${host} \
	--with-cfitsio-libs="$(cfitsio_LIBS_CC)" \
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



