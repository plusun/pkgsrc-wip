# $NetBSD: buildlink3.mk,v 1.2 2013/05/06 17:00:26 othyro Exp $

BUILDLINK_TREE+=	libkate

.if !defined(LIBKATE_BUILDLINK3_MK)
LIBKATE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.libkate+=	libkate>=0.4.1
BUILDLINK_PKGSRCDIR.libkate?=	../../wip/libkate

pkgbase := libkate
.include "../../mk/pkg-build-options.mk"

.include "../../mk/dlopen.buildlink3.mk"
.include "../../multimedia/libogg/buildlink3.mk"
.endif	# LIBKATE_BUILDLINK3_MK

BUILDLINK_TREE+=	-libkate
