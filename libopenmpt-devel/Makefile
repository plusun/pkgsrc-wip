# $NetBSD: Makefile,v 1.6 2014/09/01 17:35:10 thomasklausner Exp $

DISTNAME=	libopenmpt-0.2.4231
CATEGORIES=	audio
MASTER_SITES=	http://buildbot.openmpt.org/builds/auto/src/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://lib.openmpt.org/libopenmpt/
COMMENT=	Library to decode tracked music files into a raw PCM audio stream (development version)
LICENSE=	modified-bsd

BUILD_DEPENDS+=	help2man-[0-9]*:../../converters/help2man

USE_LANGUAGES=	c c++
USE_TOOLS=	gmake pkg-config
MAKE_FLAGS+=	MANDIR=${PREFIX}/${PKGMANDIR}
MAKE_FLAGS+=	INSTALL_LIB=${INSTALL_LIB:Q}

PKGCONFIG_OVERRIDE=		bin/libopenmpt.pc
PKGCONFIG_OVERRIDE_STAGE=	post-build

.include "options.mk"

.include "../../devel/SDL/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
