# $NetBSD: Makefile,v 1.3 2013/04/19 11:27:28 othyro Exp $
#

DISTNAME=	ttf-arphic-ukai_0.2.20080216.1.orig
PKGNAME=	${DISTNAME:S/ttf-arphic-ukai_/arphic-ukai-ttf-/:S/.orig//}
CATEGORIES=	fonts chinese
MASTER_SITES=	${MASTER_SITE_DEBIAN:=pool/main/t/ttf-arphic-ukai/}

MAINTAINER=	ryoon@NetBSD.org
HOMEPAGE=	http://www.freedesktop.org/wiki/Software/CJKUnifonts
COMMENT=	High-quality Chinese Unicode TrueType font, Kaiti style
LICENSE=	arphic-public

WRKSRC=		${WRKDIR}

USE_X11BASE=	yes
NO_CONFIGURE=	yes
NO_BUILD=	yes
USE_LANGUAGES=	# none

DOCDIR=		${PREFIX}/share/doc/${PKGBASE}

INSTALLATION_DIRS=	lib/X11/fonts/TTF \
			${DOCDIR}

FONTDIR=	${PREFIX}/lib/X11/fonts/TTF
FONTS_DIRS.ttf=	${FONTDIR}

INSTALL_FONTS=	ukai.ttc

INSTALL_DOCS=	FONTLOG \
		license/english/ARPHICPL.TXT

do-install:
.for f in ${INSTALL_FONTS}
	${INSTALL_DATA} ${WRKSRC}/${f} ${DESTDIR}${FONTDIR}
.endfor
.for f in ${INSTALL_DOCS}
	${INSTALL_DATA} ${WRKSRC}/${f} ${DESTDIR}${DOCDIR}
.endfor

.include "../../mk/bsd.pkg.mk"
