# $NetBSD: Makefile,v 1.1 2015/02/11 00:16:25 jmcneill Exp $

DISTNAME=	libretro-beetle-pce-fast-20171202
CATEGORIES=	emulators
MASTER_SITES=	${MASTER_SITE_GITHUB:=libretro/}
GITHUB_PROJECT=	beetle-pce-fast-libretro
GITHUB_TAG=	0f1326a24a6cc802f7a6ece75a3d95232101f240

MAINTAINER=	nia.alarie@gmail.com
HOMEPAGE=	https://docs.libretro.com/library/beetle_pce_fast/
COMMENT=	Libretro core based on the Mednafen PC Engine emulator
LICENSE=	gnu-gpl-v2

EXTRACT_USING=	bsdtar

USE_TOOLS+=	gmake
USE_LANGUAGES=	c c++

MAKE_FLAGS+=	GIT_VERSION="-pkgsrc"

PKGCONFIG_OVERRIDE+=	mednafen/tremor/vorbisidec.pc.in

INSTALLATION_DIRS+=	${PREFIX}/lib/libretro

.include "../../mk/endian.mk"

.if ${MACHINE_ENDIAN} == "big"
CFLAGS+=	-DMSB_FIRST
CFLAGS+=	-DBYTE_ORDER=BIG_ENDIAN
.endif

do-install:
	${INSTALL_LIB} ${WRKSRC}/mednafen_pce_fast_libretro.so \
	    ${DESTDIR}${PREFIX}/lib/libretro/mednafen_pce_fast_libretro.so

.include "../../mk/bsd.pkg.mk"
