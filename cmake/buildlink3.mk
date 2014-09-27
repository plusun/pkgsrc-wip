# $NetBSD: buildlink3.mk,v 1.1 2014/09/27 06:05:02 makoto Exp $

BUILDLINK_TREE+=	cmake

.if !defined(CMAKE_BUILDLINK3_MK)
CMAKE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.cmake+=	cmake>=2.8.5nb1
BUILDLINK_PKGSRCDIR.cmake?=	../../wip/cmake
BUILDLINK_DEPMETHOD.cmake?=	build
BUILDLINK_FILES.cmake+=		share/cmake-*/include/*
.endif # CMAKE_BUILDLINK3_MK

BUILDLINK_TREE+=	-cmake
