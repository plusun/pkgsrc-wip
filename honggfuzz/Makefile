GITHUB_PROJECT= honggfuzz
DISTNAME=       honggfuzz-oss-fuzz
CATEGORIES=     devel
MASTER_SITES=   ${MASTER_SITE_GITHUB:=google/}
GITHUB_TAG=     oss-fuzz
EXTRACT_SUFX=   .zip
DIST_SUBDIR=    ${GITHUB_PROJECT}

MAINTAINER=     tomsun.0.7@gmail.com
HOMEPAGE=       https://github.com/google/honggfuzz/
COMMENT=        A security oriented, feedback-driven, evolutionary, easy-to-use fuzzer with interesting analysis options.
LICENSE=        apache-2.0

USE_TOOLS+= bash:run gmake

WRKSRC=	${WRKDIR}/honggfuzz-oss-fuzz

.include "../../mk/bsd.pkg.mk"
