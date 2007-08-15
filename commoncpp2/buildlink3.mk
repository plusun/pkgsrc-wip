# $NetBSD: buildlink3.mk,v 1.3 2007/08/15 19:14:48 othyro Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
COMMONCPP2_BUILDLINK3_MK:=	${COMMONCPP2_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	commoncpp2
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ncommoncpp2}
BUILDLINK_PACKAGES+=	commoncpp2
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}commoncpp2

.if ${COMMONCPP2_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.commoncpp2+=	commoncpp2>=1.5.3
BUILDLINK_PKGSRCDIR.commoncpp2?=	../../wip/commoncpp2
.endif	# COMMONCPP2_BUILDLINK3_MK

.include "../../textproc/libxml2/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
