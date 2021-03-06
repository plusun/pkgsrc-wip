$NetBSD: patch-libkms_vmwgfx.c,v 1.3 2015/05/07 06:31:06 wiz Exp $

Provide compatibility errno number for non-Linux.

From FreeBSD ports for graphics/libdrm version 2.4.84

# the defintion of ERESTART is behind a check for _KERNEL, but
# defining that causes errno to not be defined. fortunately, there's
# an alternative switch. unfortunately, those differ by platform and
# _WANT_KERNEL_ERRNO is too recent to be part of any release, so just
# define ERESTART if we still don't have it after including errno.h 

--- libkms/vmwgfx.c.orig	2017-11-03 16:44:27.000000000 +0000
+++ libkms/vmwgfx.c
@@ -30,15 +30,31 @@
 #include "config.h"
 #endif
 
+#if defined (__FreeBSD__) || defined (__FreeBSD_kernel__)
+#define _WANT_KERNEL_ERRNO
+#elif defined(__DragonFly__)
+#define _KERNEL_STRUCTURES
+#endif
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
 #include "internal.h"
 
+#if defined (__FreeBSD__) || defined (__FreeBSD_kernel__) || defined(__DragonFly__)
+#ifndef ERESTART
+#define ERESTART (-1)
+#endif
+#else
+#ifndef ERESTART
+#define ERESTART 85
+#endif
+#endif
+
 #include "xf86drm.h"
 #include "libdrm_macros.h"
 #include "vmwgfx_drm.h"
 
+
 struct vmwgfx_bo
 {
 	struct kms_bo base;
