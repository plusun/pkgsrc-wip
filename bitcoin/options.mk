# $NetBSD$

# TODO: support qt5 also (or perhaps instead)

PKG_OPTIONS_VAR=		PKG_OPTIONS.bitcoin
PKG_SUPPORTED_OPTIONS+=		qt4 miniupnpc
# qt4 is off because it doubles the footprint of the package.
# Please do not enable it by default; instead, create a split
# package.
PKG_SUGGESTED_OPTIONS+=

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mqt4)
PLIST.qt4=	yes

.include "../../converters/qrencode/buildlink3.mk"
.include "../../devel/protobuf/buildlink3.mk"
BUILDLINK_DEPMETHOD.qt4-tools=	full
.include "../../x11/qt4-tools/buildlink3.mk"
.include "../../x11/qt4-libs/buildlink3.mk"

CONFIGURE_ARGS+=	--with-qt-bindir=${QTDIR}/bin
.endif

.if !empty(PKG_OPTIONS:Mminiupnpc)
.include "../../net/miniupnpc/buildlink3.mk"
.endif
