# $NetBSD: options.mk,v 1.2 2013/03/05 00:49:21 khorben Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.deforaos-player
PKG_SUPPORTED_OPTIONS=	embedded

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Membedded)
MAKE_FLAGS+=	CPPFLAGS=-DEMBEDDED
.endif
