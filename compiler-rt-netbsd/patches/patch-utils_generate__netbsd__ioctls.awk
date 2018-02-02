$NetBSD$

--- utils/generate_netbsd_ioctls.awk.orig	2018-02-02 13:51:14.446124820 +0000
+++ utils/generate_netbsd_ioctls.awk
@@ -0,0 +1,755 @@
+#!/usr/bin/awk -f
+
+#===-- generate_netbsd_ioctls.awk ------------------------------------------===#
+#
+#                     The LLVM Compiler Infrastructure
+#
+# This file is distributed under the University of Illinois Open Source
+# License. See LICENSE.TXT for details.
+#
+#===------------------------------------------------------------------------===#
+#
+# This file is a generator of:
+#  - include/sanitizer/sanitizer_netbsd_interceptors_ioctl.inc
+#
+# This script reads public headers from a NetBSD host.
+#
+#===------------------------------------------------------------------------===#
+
+BEGIN {
+  # harcode the script name
+  script_name = "generate_netbsd_ioctls.awk"
+  outputinc = "../lib/sanitizer_common/sanitizer_netbsd_interceptors_ioctl.inc"
+
+  # assert that we are in the directory with scripts
+  in_utils = system("test -f " script_name " && exit 1 || exit 0")
+  if (in_utils == 0) {
+    usage()
+  }
+
+  # assert 0 argument passed
+  if (ARGC != 1) {
+    usage()
+  }
+
+  # accept overloading CLANGFORMAT from environment
+  clangformat = "clang-format"
+  if ("CLANGFORMAT" in ENVIRON) {
+    clangformat = ENVIRON["CLANGFORMAT"]
+  }
+
+  # accept overloading ROOTDIR from environment
+  rootdir = "/usr/include/"
+  if ("ROOTDIR" in ENVIRON) {
+    rootdir = ENVIRON["ROOTDIR"]
+  }
+
+  # hardcode list of headers with ioctl(2) entries
+  # List generated manually with the following script:
+  #   for w in `find /usr/include/ -type f -name '*.h' -exec echo {} \;`; \
+  #   do awk '/[^a-zA-Z0-9_]_IO[W]*[R]*[ ]*\(/ && $2 ~ /^[A-Z_]+$/ {got=1} END{if(got) {print ARGV[1]}}' $w; \
+  #   done|awk '{print "  ARGV[ARGC++] = rootdir \"" substr($0, 14) "\""}'
+
+  ARGV[ARGC++] = rootdir "altq/altq_afmap.h"
+  ARGV[ARGC++] = rootdir "altq/altq.h"
+  ARGV[ARGC++] = rootdir "altq/altq_blue.h"
+  ARGV[ARGC++] = rootdir "altq/altq_cbq.h"
+  ARGV[ARGC++] = rootdir "altq/altq_cdnr.h"
+  ARGV[ARGC++] = rootdir "altq/altq_fifoq.h"
+  ARGV[ARGC++] = rootdir "altq/altq_hfsc.h"
+  ARGV[ARGC++] = rootdir "altq/altq_jobs.h"
+  ARGV[ARGC++] = rootdir "altq/altq_priq.h"
+  ARGV[ARGC++] = rootdir "altq/altq_red.h"
+  ARGV[ARGC++] = rootdir "altq/altq_rio.h"
+  ARGV[ARGC++] = rootdir "altq/altq_wfq.h"
+  ARGV[ARGC++] = rootdir "crypto/cryptodev.h"
+  ARGV[ARGC++] = rootdir "dev/apm/apmio.h"
+  ARGV[ARGC++] = rootdir "dev/dm/netbsd-dm.h"
+  ARGV[ARGC++] = rootdir "dev/dmover/dmover_io.h"
+  ARGV[ARGC++] = rootdir "dev/dtv/dtvio_demux.h"
+  ARGV[ARGC++] = rootdir "dev/dtv/dtvio_frontend.h"
+  ARGV[ARGC++] = rootdir "dev/filemon/filemon.h"
+  ARGV[ARGC++] = rootdir "dev/hdaudio/hdaudioio.h"
+  ARGV[ARGC++] = rootdir "dev/hdmicec/hdmicecio.h"
+  ARGV[ARGC++] = rootdir "dev/hpc/hpcfbio.h"
+  ARGV[ARGC++] = rootdir "dev/i2o/iopio.h"
+  ARGV[ARGC++] = rootdir "dev/ic/athioctl.h"
+  ARGV[ARGC++] = rootdir "dev/ic/bt8xx.h"
+  ARGV[ARGC++] = rootdir "dev/ic/hd44780var.h"
+  ARGV[ARGC++] = rootdir "dev/ic/icp_ioctl.h"
+  ARGV[ARGC++] = rootdir "dev/ic/isp_ioctl.h"
+  ARGV[ARGC++] = rootdir "dev/ic/mlxio.h"
+  ARGV[ARGC++] = rootdir "dev/ic/nvmeio.h"
+  ARGV[ARGC++] = rootdir "dev/ir/irdaio.h"
+  ARGV[ARGC++] = rootdir "dev/isa/satlinkio.h"
+  ARGV[ARGC++] = rootdir "dev/isa/isvio.h"
+  ARGV[ARGC++] = rootdir "dev/isa/wtreg.h"
+  ARGV[ARGC++] = rootdir "dev/iscsi/iscsi_ioctl.h"
+  ARGV[ARGC++] = rootdir "dev/ofw/openfirmio.h"
+  ARGV[ARGC++] = rootdir "dev/pci/amrio.h"
+  ARGV[ARGC++] = rootdir "dev/pci/mlyio.h"
+  ARGV[ARGC++] = rootdir "dev/pci/pciio.h"
+  ARGV[ARGC++] = rootdir "dev/pci/tweio.h"
+  ARGV[ARGC++] = rootdir "dev/pcmcia/if_cnwioctl.h"
+  ARGV[ARGC++] = rootdir "dev/pcmcia/if_rayreg.h"
+  ARGV[ARGC++] = rootdir "dev/raidframe/raidframeio.h"
+  ARGV[ARGC++] = rootdir "dev/sbus/mbppio.h"
+  ARGV[ARGC++] = rootdir "dev/scsipi/ses.h"
+  ARGV[ARGC++] = rootdir "dev/sun/disklabel.h"
+  ARGV[ARGC++] = rootdir "dev/sun/fbio.h"
+  ARGV[ARGC++] = rootdir "dev/sun/kbio.h"
+  ARGV[ARGC++] = rootdir "dev/sun/vuid_event.h"
+  ARGV[ARGC++] = rootdir "dev/tc/sticio.h"
+  ARGV[ARGC++] = rootdir "dev/usb/ukyopon.h"
+  ARGV[ARGC++] = rootdir "dev/usb/urio.h"
+  ARGV[ARGC++] = rootdir "dev/usb/usb.h"
+  ARGV[ARGC++] = rootdir "dev/usb/utoppy.h"
+  ARGV[ARGC++] = rootdir "dev/vme/xio.h"
+  ARGV[ARGC++] = rootdir "dev/wscons/wsdisplay_usl_io.h"
+  ARGV[ARGC++] = rootdir "dev/wscons/wsconsio.h"
+  ARGV[ARGC++] = rootdir "dev/biovar.h"
+  ARGV[ARGC++] = rootdir "dev/md.h"
+  ARGV[ARGC++] = rootdir "dev/ccdvar.h"
+  ARGV[ARGC++] = rootdir "dev/cgdvar.h"
+  ARGV[ARGC++] = rootdir "dev/fssvar.h"
+  ARGV[ARGC++] = rootdir "dev/bluetooth/btdev.h"
+  ARGV[ARGC++] = rootdir "dev/bluetooth/btsco.h"
+  ARGV[ARGC++] = rootdir "dev/kttcpio.h"
+  ARGV[ARGC++] = rootdir "dev/lockstat.h"
+  ARGV[ARGC++] = rootdir "dev/vndvar.h"
+  ARGV[ARGC++] = rootdir "dev/spkrio.h"
+  ARGV[ARGC++] = rootdir "net/bpf.h"
+  ARGV[ARGC++] = rootdir "net/if_atm.h"
+  ARGV[ARGC++] = rootdir "net/if_gre.h"
+  ARGV[ARGC++] = rootdir "net/if_ppp.h"
+  ARGV[ARGC++] = rootdir "net/npf.h"
+  ARGV[ARGC++] = rootdir "net/if_pppoe.h"
+  ARGV[ARGC++] = rootdir "net/if_sppp.h"
+  ARGV[ARGC++] = rootdir "net/if_srt.h"
+  ARGV[ARGC++] = rootdir "net/if_tap.h"
+  ARGV[ARGC++] = rootdir "net/if_tun.h"
+  ARGV[ARGC++] = rootdir "net/pfvar.h"
+  ARGV[ARGC++] = rootdir "net/slip.h"
+  ARGV[ARGC++] = rootdir "netbt/hci.h"
+  ARGV[ARGC++] = rootdir "netinet/ip_nat.h"
+  ARGV[ARGC++] = rootdir "netinet/ip_proxy.h"
+  ARGV[ARGC++] = rootdir "netinet6/in6_var.h"
+  ARGV[ARGC++] = rootdir "netnatm/natm.h"
+  ARGV[ARGC++] = rootdir "netsmb/smb_dev.h"
+  ARGV[ARGC++] = rootdir "sys/agpio.h"
+  ARGV[ARGC++] = rootdir "sys/audioio.h"
+  ARGV[ARGC++] = rootdir "sys/ataio.h"
+  ARGV[ARGC++] = rootdir "sys/cdio.h"
+  ARGV[ARGC++] = rootdir "sys/chio.h"
+  ARGV[ARGC++] = rootdir "sys/clockctl.h"
+  ARGV[ARGC++] = rootdir "sys/cpuio.h"
+  ARGV[ARGC++] = rootdir "sys/dkio.h"
+  ARGV[ARGC++] = rootdir "sys/drvctlio.h"
+  ARGV[ARGC++] = rootdir "sys/dvdio.h"
+  ARGV[ARGC++] = rootdir "sys/envsys.h"
+  ARGV[ARGC++] = rootdir "sys/event.h"
+  ARGV[ARGC++] = rootdir "sys/fdio.h"
+  ARGV[ARGC++] = rootdir "sys/filio.h"
+  ARGV[ARGC++] = rootdir "sys/gpio.h"
+  ARGV[ARGC++] = rootdir "sys/ioctl.h"
+  ARGV[ARGC++] = rootdir "sys/ioctl_compat.h"
+  ARGV[ARGC++] = rootdir "sys/joystick.h"
+  ARGV[ARGC++] = rootdir "sys/ksyms.h"
+  ARGV[ARGC++] = rootdir "sys/lua.h"
+  ARGV[ARGC++] = rootdir "sys/midiio.h"
+  ARGV[ARGC++] = rootdir "sys/mtio.h"
+  ARGV[ARGC++] = rootdir "sys/power.h"
+  ARGV[ARGC++] = rootdir "sys/radioio.h"
+  ARGV[ARGC++] = rootdir "sys/rndio.h"
+  ARGV[ARGC++] = rootdir "sys/scanio.h"
+  ARGV[ARGC++] = rootdir "sys/scsiio.h"
+  ARGV[ARGC++] = rootdir "sys/sockio.h"
+  ARGV[ARGC++] = rootdir "sys/timepps.h"
+  ARGV[ARGC++] = rootdir "sys/ttycom.h"
+  ARGV[ARGC++] = rootdir "sys/verified_exec.h"
+  ARGV[ARGC++] = rootdir "sys/videoio.h"
+  ARGV[ARGC++] = rootdir "sys/wdog.h"
+  ARGV[ARGC++] = rootdir "soundcard.h"
+  ARGV[ARGC++] = rootdir "xen/xenio.h"
+
+  ioctl_table_max = 0
+}
+
+# Scan RCS ID
+FNR == 1 {
+  fname[ioctl_table_max] = substr(FILENAME, length(rootdir) + 1)
+}
+
+# _IO
+/[^a-zA-Z0-9_]_IO[W]*[R]*[ ]*\(/ && $2 ~ /^[A-Z_]+$/ {
+  if ($0 ~ /RAIDFRAME_GET_ACCTOTALS/ ||
+      $0 ~ /ALTQATTACH/ ||
+      $0 ~ /ALTQDETACH/ ||
+      $0 ~ /ALTQENABLE/ ||
+      $0 ~ /ALTQDISABLE/ ||
+      $0 ~ /ALTQCLEAR/ ||
+      $0 ~ /ALTQCONFIG/ ||
+      $0 ~ /ALTQADDCLASS/ ||
+      $0 ~ /ALTQMODCLASS/ ||
+      $0 ~ /ALTQDELCLASS/ ||
+      $0 ~ /ALTQADDFILTER/ ||
+      $0 ~ /ALTQDELFILTER/ ||
+      $0 ~ /ALTQGETSTATS/ ||
+      $0 ~ /ALTQGETCNTR/ ||
+      $0 ~ /HLCD_DISPCTL/ ||
+      $0 ~ /HLCD_RESET/ ||
+      $0 ~ /HLCD_CLEAR/ ||
+      $0 ~ /HLCD_CURSOR_LEFT/ ||
+      $0 ~ /HLCD_CURSOR_RIGHT/ ||
+      $0 ~ /HLCD_GET_CURSOR_POS/ ||
+      $0 ~ /HLCD_SET_CURSOR_POS/ ||
+      $0 ~ /HLCD_GETC/ ||
+      $0 ~ /HLCD_PUTC/ ||
+      $0 ~ /HLCD_SHIFT_LEFT/ ||
+      $0 ~ /HLCD_SHIFT_RIGHT/ ||
+      $0 ~ /HLCD_HOME/ ||
+      $0 ~ /HLCD_WRITE/ ||
+      $0 ~ /HLCD_READ/ ||
+      $0 ~ /HLCD_REDRAW/ ||
+      $0 ~ /HLCD_WRITE_INST/ ||
+      $0 ~ /HLCD_WRITE_DATA/ ||
+      $0 ~ /HLCD_GET_INFO/ ||
+      $0 ~ /HLCD_GET_CHIPNO/ ||
+      $0 ~ /HLCD_SET_CHIPNO/ ||
+      $0 ~ /RAIDFRAME_TEST_ACC/ ||
+      $0 ~ /FBIOGINFO/ ||
+      $0 ~ /FBIOSATTR/ ||
+      $0 ~ /OBIOCDISK/ ||
+      $0 ~ /OBIOCVOL/ ||
+      $0 ~ /BIOCSORTIMEOUT/ ||
+      $0 ~ /BIOCGORTIMEOUT/ ||
+      $0 ~ /PPPIOCSPASS/ ||
+      $0 ~ /PPPIOCSACTIVE/ ||
+      $0 ~ /PPPIOCSIPASS/ ||
+      $0 ~ /PPPIOCSOPASS/ ||
+      $0 ~ /PPPIOCSIACTIVE/ ||
+      $0 ~ /PPPIOCSOACTIVE/ ||
+      $0 ~ /SIOCPROXY/ ||
+      $0 ~ /SIOCXRAWATM/ ||
+      $0 ~ /AGPIOC_RESERVE/ ||
+      $0 ~ /AGPIOC_PROTECT/ ||
+      $0 ~ /CDIOCREADSUBCHANNEL_BUF/ ||
+      $0 ~ /CDIOREADTOCENTRIES_BUF/ ||
+      $0 ~ /MMCGETDISCINFO/ ||
+      $0 ~ /MMCGETTRACKINFO/ ||
+      $0 ~ /MMCOP/ ||
+      $0 ~ /MMCSETUPWRITEPARAMS/ ||
+      $0 ~ /DIOCGPARTINFO/ ||
+      $0 ~ /ODIOCGDINFO/ ||
+      $0 ~ /ODIOCSDINFO/ ||
+      $0 ~ /ODIOCWDINFO/ ||
+      $0 ~ /ODIOCGDEFLABEL/ ||
+      $0 ~ /GPIOPINREAD/ ||
+      $0 ~ /GPIOPINWRITE/ ||
+      $0 ~ /GPIOPINTOGGLE/ ||
+      $0 ~ /GPIOPINCTL/ ||
+      $0 ~ /GPIODETACH/ ||
+      $0 ~ /SEQUENCER_PERCMODE/ ||
+      $0 ~ /SEQUENCER_TESTMIDI/ ||
+      $0 ~ /SEQUENCER_MIDI_INFO/ ||
+      $0 ~ /SEQUENCER_ID/ ||
+      $0 ~ /SEQUENCER_CONTROL/ ||
+      $0 ~ /SEQUENCER_REMOVESAMPLE/ ||
+      $0 ~ /EVTCHN_RESET/ ||
+      $0 ~ /EVTCHN_BIND/ ||
+      $0 ~ /EVTCHN_UNBIND/) {
+    # broken entry, incomplete definition of the 3rd parameterm etc
+    next
+  }
+
+  if ($0 ~ /APM_IOC_STANDBY/ ||
+      $0 ~ /APM_IOC_SUSPEND/ ||
+      $0 ~ /SCIOC_USE_ADF/ ||
+      $0 ~ /SCBUSIOLLSCAN/ ||
+      $0 ~ /UTOPPYIOCANCEL/ ||
+      $0 ~ /JOY_GET_X_OFFSET/ ||
+      $0 ~ /CHIOGPICKER/ ||
+      $0 ~ /SLIOCGUNIT/ ||
+      $0 ~ /SATIOSBUFSIZE/ ||
+      $0 ~ /TUNSLMODE/ ||
+      $0 ~ /CBQ_IF_ATTACH/ ||
+      $0 ~ /CDNR_IF_ATTACH/ ||
+      $0 ~ /RIO_IF_ATTACH/ ||
+      $0 ~ /CBQ_IF_DETACH/ ||
+      $0 ~ /HFSC_IF_DETACH/ ||
+      $0 ~ /WFQ_IF_DETACH/ ||
+      $0 ~ /RIO_IF_DETACH/ ||
+      $0 ~ /FIFOQ_IF_DETACH/ ||
+      $0 ~ /RED_IF_DETACH/ ||
+      $0 ~ /CDNR_ENABLE/ ||
+      $0 ~ /HFSC_ENABLE/ ||
+      $0 ~ /WFQ_ENABLE/ ||
+      $0 ~ /RIO_ENABLE/ ||
+      $0 ~ /FIFOQ_ENABLE/ ||
+      $0 ~ /RED_ENABLE/ ||
+      $0 ~ /BLUE_ENABLE/ ||
+      $0 ~ /CDNR_DISABLE/ ||
+      $0 ~ /HFSC_DISABLE/ ||
+      $0 ~ /WFQ_DISABLE/ ||
+      $0 ~ /RIO_DISABLE/ ||
+      $0 ~ /FIFOQ_DISABLE/ ||
+      $0 ~ /PRIQ_DISABLE/ ||
+      $0 ~ /CDNR_DEL_FILTER/ ||
+      $0 ~ /JOBS_DEL_CLASS/ ||
+      $0 ~ /JOBS_DEL_FILTER/ ||
+      $0 ~ /JOBS_GETSTATS/ ||
+      $0 ~ /WFQ_GET_STATS/ ||
+      $0 ~ /CBQ_ADD_FILTER/ ||
+      $0 ~ /HFSC_ADD_FILTER/ ||
+      $0 ~ /JOBS_ADD_FILTER/ ||
+      $0 ~ /RED_IF_ATTACH/ ||
+      $0 ~ /FIFOQ_IF_ATTACH/ ||
+      $0 ~ /BLUE_IF_DETACH/ ||
+      $0 ~ /CBQ_DISABLE/ ||
+      $0 ~ /RED_DISABLE/ ||
+      $0 ~ /CBQ_CLEAR_HIERARCHY/ ||
+      $0 ~ /HFSC_DEL_CLASS/ ||
+      $0 ~ /PRIQ_IF_DETACH/ ||
+      $0 ~ /PRIQ_ENABLE/ ||
+      $0 ~ /WFQ_IF_ATTACH/ ||
+      $0 ~ /HFSC_DEL_FILTER/) {
+    # There are entries with duplicate codes.. disable the less used ones
+    next
+  }
+
+  if ($2 in known) {
+    # Avoid duplicates
+    # There are entries compatible with K&R and ANSI preprocessor
+    next
+  }
+
+  known[$2] = 1
+
+  ioctl_name[ioctl_table_max] = $2
+
+  split($3, a, "(")
+  a3 = a[1]
+  if (a3 ~ /_IO[ ]*$/) {
+    ioctl_mode[ioctl_table_max] = "NONE"
+  } else if (a3 ~ /_IOR[ ]*$/) {
+    ioctl_mode[ioctl_table_max] = "WRITE"
+  } else if (a3 ~ /_IOW[ ]*$/) {
+    ioctl_mode[ioctl_table_max] = "READ"
+  } else if (a3 ~ /_IOWR[ ]*$/) {
+    ioctl_mode[ioctl_table_max] = "READWRITE"
+  } else {
+    print "Unknown mode, cannot parse: '" $3 "'"
+  }
+
+  # This !NONE check allows to skip some unparsable entries
+  if (ioctl_mode[ioctl_table_max] != "NONE") {
+    # special cases first
+    if ($0 ~ /POWER_IOC_GET_TYPE_WITH_LOSSAGE/) {
+      ioctl_type[ioctl_table_max] = "sizeof(uptr)"
+    } else {
+      n = split($0, a, ",")
+      if (n == 3) {
+        gsub(/^[ ]+/, "", a[3])
+        match(a[3], /[a-zA-Z0-9_* ]+/)
+        type = get_type(substr(a[3], 0, RLENGTH))
+        ioctl_type[ioctl_table_max] = type
+      }
+    }
+  }
+
+  ioctl_table_max++
+}
+
+END {
+  # empty files?
+  if (NR < 1 && !abnormal_exit) {
+    usage()
+  }
+
+  # Handle abnormal exit
+  if (abnormal_exit) {
+    exit(abnormal_exit)
+  }
+
+  # Generate sanitizer_netbsd_ioctls.inc
+
+  # open pipe
+  cmd = clangformat " > " outputinc
+
+  pcmd("//===-- sanitizer_common_interceptors_ioctl.inc -----------------*- C++ -*-===//")
+  pcmd("//")
+  pcmd("//                     The LLVM Compiler Infrastructure")
+  pcmd("//")
+  pcmd("// This file is distributed under the University of Illinois Open Source")
+  pcmd("// License. See LICENSE.TXT for details.")
+  pcmd("//")
+  pcmd("//===----------------------------------------------------------------------===//")
+  pcmd("//")
+  pcmd("// Ioctl handling in common sanitizer interceptors.")
+  pcmd("//===----------------------------------------------------------------------===//")
+  pcmd("")
+  pcmd("#if SANITIZER_NETBSD")
+  pcmd("")
+  pcmd("#include \"sanitizer_flags.h\"")
+  pcmd("")
+  pcmd("struct ioctl_desc {")
+  pcmd("  unsigned req;")
+  pcmd("  // FIXME: support read+write arguments. Currently READWRITE and WRITE do the")
+  pcmd("  // same thing.")
+  pcmd("  // XXX: The declarations below may use WRITE instead of READWRITE, unless")
+  pcmd("  // explicitly noted.")
+  pcmd("  enum {")
+  pcmd("    NONE,")
+  pcmd("    READ,")
+  pcmd("    WRITE,")
+  pcmd("    READWRITE,")
+  pcmd("    CUSTOM")
+  pcmd("  } type : 3;")
+  pcmd("  unsigned size : 29;")
+  pcmd("  const char* name;")
+  pcmd("};")
+  pcmd("")
+  pcmd("const unsigned ioctl_table_max = " ioctl_table_max ";")
+  pcmd("static ioctl_desc ioctl_table[ioctl_table_max];")
+  pcmd("static unsigned ioctl_table_size = 0;")
+  pcmd("")
+  pcmd("// This can not be declared as a global, because references to struct_*_sz")
+  pcmd("// require a global initializer. And this table must be available before global")
+  pcmd("// initializers are run.")
+  pcmd("static void ioctl_table_fill() {")
+  pcmd("#define _(rq, tp, sz)                                    \\")
+  pcmd("  if (IOCTL_##rq != IOCTL_NOT_PRESENT) {                 \\")
+  pcmd("    CHECK(ioctl_table_size < ioctl_table_max);           \\")
+  pcmd("    ioctl_table[ioctl_table_size].req = IOCTL_##rq;      \\")
+  pcmd("    ioctl_table[ioctl_table_size].type = ioctl_desc::tp; \\")
+  pcmd("    ioctl_table[ioctl_table_size].size = sz;             \\")
+  pcmd("    ioctl_table[ioctl_table_size].name = #rq;            \\")
+  pcmd("    ++ioctl_table_size;                                  \\")
+  pcmd("  }")
+  pcmd("")
+
+  for (i = 0; i < ioctl_table_max; i++) {
+    if (i in fname) {
+      pcmd("  /* Entries from file: " fname[i] " */")
+    }
+
+    if (i in ioctl_type) {
+      type = ioctl_type[i]
+    } else {
+      type = "0"
+    }
+
+    pcmd("  _(" ioctl_name[i] ", " ioctl_mode[i] "," type ");")
+  }
+
+  pcmd("#undef _")
+  pcmd("}")
+  pcmd("")
+  pcmd("static bool ioctl_initialized = false;")
+  pcmd("")
+  pcmd("struct ioctl_desc_compare {")
+  pcmd("  bool operator()(const ioctl_desc& left, const ioctl_desc& right) const {")
+  pcmd("    return left.req < right.req;")
+  pcmd("  }")
+  pcmd("};")
+  pcmd("")
+  pcmd("static void ioctl_init() {")
+  pcmd("  ioctl_table_fill();")
+  pcmd("  InternalSort(&ioctl_table, ioctl_table_size, ioctl_desc_compare());")
+  pcmd("")
+  pcmd("  bool bad = false;")
+  pcmd("  for (unsigned i = 0; i < ioctl_table_size - 1; ++i) {")
+  pcmd("    if (ioctl_table[i].req >= ioctl_table[i + 1].req) {")
+  pcmd("      Printf(\"Duplicate or unsorted ioctl request id %x >= %x (%s vs %s)\\n\",")
+  pcmd("             ioctl_table[i].req, ioctl_table[i + 1].req, ioctl_table[i].name,")
+  pcmd("             ioctl_table[i + 1].name);")
+  pcmd("      bad = true;")
+  pcmd("    }")
+  pcmd("  }")
+  pcmd("")
+  pcmd("  if (bad) Die();")
+  pcmd("")
+  pcmd("  ioctl_initialized = true;")
+  pcmd("}")
+  pcmd("")
+  pcmd("static const ioctl_desc *ioctl_table_lookup(unsigned req) {")
+  pcmd("  int left = 0;")
+  pcmd("  int right = ioctl_table_size;")
+  pcmd("  while (left < right) {")
+  pcmd("    int mid = (left + right) / 2;")
+  pcmd("    if (ioctl_table[mid].req < req)")
+  pcmd("      left = mid + 1;")
+  pcmd("    else")
+  pcmd("      right = mid;")
+  pcmd("  }")
+  pcmd("  if (left == right && ioctl_table[left].req == req)")
+  pcmd("    return ioctl_table + left;")
+  pcmd("  else")
+  pcmd("    return nullptr;")
+  pcmd("}")
+  pcmd("")
+  pcmd("static bool ioctl_decode(unsigned req, ioctl_desc *desc) {")
+  pcmd("  CHECK(desc);")
+  pcmd("  desc->req = req;")
+  pcmd("  desc->name = \"<DECODED_IOCTL>\";")
+  pcmd("  desc->size = IOC_SIZE(req);")
+  pcmd("  // Sanity check.")
+  pcmd("  if (desc->size > 0xFFFF) return false;")
+  pcmd("  unsigned dir = IOC_DIR(req);")
+  pcmd("  switch (dir) {")
+  pcmd("    case IOC_NONE:")
+  pcmd("      desc->type = ioctl_desc::NONE;")
+  pcmd("      break;")
+  pcmd("    case IOC_READ | IOC_WRITE:")
+  pcmd("      desc->type = ioctl_desc::READWRITE;")
+  pcmd("      break;")
+  pcmd("    case IOC_READ:")
+  pcmd("      desc->type = ioctl_desc::WRITE;")
+  pcmd("      break;")
+  pcmd("    case IOC_WRITE:")
+  pcmd("      desc->type = ioctl_desc::READ;")
+  pcmd("      break;")
+  pcmd("    default:")
+  pcmd("      return false;")
+  pcmd("  }")
+  pcmd("  // Size can be 0 iff type is NONE.")
+  pcmd("  if ((desc->type == IOC_NONE) != (desc->size == 0)) return false;")
+  pcmd("  // Sanity check.")
+  pcmd("  if (IOC_TYPE(req) == 0) return false;")
+  pcmd("  return true;")
+  pcmd("}")
+  pcmd("")
+  pcmd("static const ioctl_desc *ioctl_lookup(unsigned req) {")
+  pcmd("  const ioctl_desc *desc = ioctl_table_lookup(req);")
+  pcmd("  if (desc) return desc;")
+  pcmd("")
+  pcmd("  // Try stripping access size from the request id.")
+  pcmd("  desc = ioctl_table_lookup(req & ~(IOC_SIZEMASK << IOC_SIZESHIFT));")
+  pcmd("  // Sanity check: requests that encode access size are either read or write and")
+  pcmd("  // have size of 0 in the table.")
+  pcmd("  if (desc && desc->size == 0 &&")
+  pcmd("      (desc->type == ioctl_desc::READWRITE || desc->type == ioctl_desc::WRITE ||")
+  pcmd("       desc->type == ioctl_desc::READ))")
+  pcmd("    return desc;")
+  pcmd("  return nullptr;")
+  pcmd("}")
+  pcmd("")
+  pcmd("static void ioctl_common_pre(void *ctx, const ioctl_desc *desc, int d,")
+  pcmd("                             unsigned request, void *arg) {")
+  pcmd("  if (desc->type == ioctl_desc::READ || desc->type == ioctl_desc::READWRITE) {")
+  pcmd("    unsigned size = desc->size ? desc->size : IOC_SIZE(request);")
+  pcmd("    COMMON_INTERCEPTOR_READ_RANGE(ctx, arg, size);")
+  pcmd("  }")
+  pcmd("  if (desc->type != ioctl_desc::CUSTOM)")
+  pcmd("    return;")
+  pcmd("  if (request == IOCTL_SIOCGIFCONF) {")
+  pcmd("    struct __sanitizer_ifconf *ifc = (__sanitizer_ifconf *)arg;")
+  pcmd("    COMMON_INTERCEPTOR_READ_RANGE(ctx, (char*)&ifc->ifc_len,")
+  pcmd("                                  sizeof(ifc->ifc_len));")
+  pcmd("  }")
+  pcmd("}")
+  pcmd("")
+  pcmd("static void ioctl_common_post(void *ctx, const ioctl_desc *desc, int res, int d,")
+  pcmd("                              unsigned request, void *arg) {")
+  pcmd("  if (desc->type == ioctl_desc::WRITE || desc->type == ioctl_desc::READWRITE) {")
+  pcmd("    // FIXME: add verbose output")
+  pcmd("    unsigned size = desc->size ? desc->size : IOC_SIZE(request);")
+  pcmd("    COMMON_INTERCEPTOR_WRITE_RANGE(ctx, arg, size);")
+  pcmd("  }")
+  pcmd("  if (desc->type != ioctl_desc::CUSTOM)")
+  pcmd("    return;")
+  pcmd("  if (request == IOCTL_SIOCGIFCONF) {")
+  pcmd("    struct __sanitizer_ifconf *ifc = (__sanitizer_ifconf *)arg;")
+  pcmd("    COMMON_INTERCEPTOR_WRITE_RANGE(ctx, ifc->ifc_ifcu.ifcu_req, ifc->ifc_len);")
+  pcmd("  }")
+  pcmd("}")
+  pcmd("")
+  pcmd("#endif // SANITIZER_NETBSD")
+
+  close(cmd)
+}
+
+function usage()
+{
+  print "Usage: " script_name
+  abnormal_exit = 1
+  exit 1
+}
+
+function pcmd(string)
+{
+  print string | cmd
+}
+
+function get_type(string)
+{
+  if (string == "int") {
+    return "sizeof(int)"
+  } else if (string == "unsigned int" || string == "u_int" || string == "uint") {
+    return "sizeof(unsigned int)"
+  } else if (string == "long") {
+    return "sizeof(long)"
+  } else if (string == "unsigned long" || string == "u_long") {
+    return "sizeof(unsigned long)"
+  } else if (string == "short") {
+    return "sizeof(short)"
+  } else if (string == "unsigned short") {
+    return "sizeof(unsigned short)"
+  } else if (string == "char") {
+    return "sizeof(char)"
+  } else if (string == "signed char") {
+    return "sizeof(signed char)"
+  } else if (string == "unsigned char") {
+    return "sizeof(unsigned char)"
+  } else if (string == "uint8_t") {
+    return "sizeof(u8)"
+  } else if (string == "uint16_t") {
+    return "sizeof(u16)"
+  } else if (string == "u_int32_t" || string == "uint32_t") {
+    return "sizeof(u32)"
+  } else if (string ~ /\*$/) {
+    return "sizeof(uptr)"
+  } else if (string == "off_t") {
+    return "sizeof(uptr)"
+  } else if (string == "pid_t" || string == "kbd_t") {
+    return "sizeof(int)"
+  } else if (string == "daddr_t" || string == "dev_t") {
+    return "sizeof(u64)"
+  } else if (substr(string, 0, 7) == "struct " ) {
+    gsub(/ /, "", string)
+    return "struct_" substr(string, 7) "_sz"
+  } else if (string == "scsireq_t") {
+    return "struct_scsireq_sz"
+  } else if (string == "tone_t") {
+    return "struct_tone_sz"
+  } else if (string == "union twe_statrequest") {
+    return "union_twe_statrequest_sz"
+  } else if (string == "usb_device_descriptor_t") {
+    return "struct_usb_device_descriptor_sz"
+  } else if (string == "v4l2_std_id") {
+    return "sizeof(u64)"
+  } else if (string == "vtmode_t") {
+    return "struct_vt_mode_sz"
+  } else if (string == "_old_mixer_info") {
+    return "struct__old_mixer_info_sz"
+  } else if (string == "agp_allocate") {
+    return "struct__agp_allocate_sz"
+  } else if (string == "agp_bind") {
+    return "struct__agp_bind_sz"
+  } else if (string == "agp_info") {
+    return "struct__agp_info_sz"
+  } else if (string == "agp_region") {
+    return "struct__agp_region_sz"
+  } else if (string == "agp_setup") {
+    return "struct__agp_setup_sz"
+  } else if (string == "agp_unbind") {
+    return "struct__agp_unbind_sz"
+  } else if (string == "atareq_t") {
+    return "struct_atareq_sz"
+  } else if (string == "cpustate_t") {
+    return "struct_cpustate_sz"
+  } else if (string == "dmx_caps_t") {
+    return "struct_dmx_caps_sz"
+  } else if (string == "dmx_source_t") {
+    return "enum_dmx_source_sz"
+  } else if (string == "dvd_authinfo") {
+    return "union_dvd_authinfo_sz"
+  } else if (string == "dvd_struct") {
+    return "union_dvd_struct_sz"
+  } else if (string == "enum v4l2_priority") {
+    return "enum_v4l2_priority_sz"
+  } else if (string == "envsys_basic_info_t") {
+    return "struct_envsys_basic_info_sz"
+  } else if (string == "envsys_tre_data_t") {
+    return "struct_envsys_tre_data_sz"
+  } else if (string == "ext_accm") {
+    return "(8 * sizeof(u32))"
+  } else if (string == "fe_sec_mini_cmd_t") {
+    return "enum_fe_sec_mini_cmd_sz"
+  } else if (string == "fe_sec_tone_mode_t") {
+    return "enum_fe_sec_tone_mode_sz"
+  } else if (string == "fe_sec_voltage_t") {
+    return "enum_fe_sec_voltage_sz"
+  } else if (string == "fe_status_t") {
+    return "enum_fe_status_sz"
+  } else if (string == "gdt_ctrt_t") {
+    return "struct_gdt_ctrt_sz"
+  } else if (string == "gdt_event_t") {
+    return "struct_gdt_event_sz"
+  } else if (string == "gdt_osv_t") {
+    return "struct_gdt_osv_sz"
+  } else if (string == "gdt_rescan_t") {
+    return "struct_gdt_rescan_sz"
+  } else if (string == "gdt_statist_t") {
+    return "struct_gdt_statist_sz"
+  } else if (string == "gdt_ucmd_t") {
+    return "struct_gdt_ucmd_sz"
+  } else if (string == "iscsi_conn_status_parameters_t") {
+    return "struct_iscsi_conn_status_parameters_sz"
+  } else if (string == "iscsi_get_version_parameters_t") {
+    return "struct_iscsi_get_version_parameters_sz"
+  } else if (string == "iscsi_iocommand_parameters_t") {
+    return "struct_iscsi_iocommand_parameters_sz"
+  } else if (string == "iscsi_login_parameters_t") {
+    return "struct_iscsi_login_parameters_sz"
+  } else if (string == "iscsi_logout_parameters_t") {
+    return "struct_iscsi_logout_parameters_sz"
+  } else if (string == "iscsi_register_event_parameters_t") {
+    return "struct_iscsi_register_event_parameters_sz"
+  } else if (string == "iscsi_remove_parameters_t") {
+    return "struct_iscsi_remove_parameters_sz"
+  } else if (string == "iscsi_send_targets_parameters_t") {
+    return "struct_iscsi_send_targets_parameters_sz"
+  } else if (string == "iscsi_set_node_name_parameters_t") {
+    return "struct_iscsi_set_node_name_parameters_sz"
+  } else if (string == "iscsi_wait_event_parameters_t") {
+    return "struct_iscsi_wait_event_parameters_sz"
+  } else if (string == "isp_stats_t") {
+    return "struct_isp_stats_sz"
+  } else if (string == "lsenable_t") {
+    return "struct_lsenable_sz"
+  } else if (string == "lsdisable_t") {
+    return "struct_lsdisable_sz"
+  } else if (string == "mixer_ctrl_t") {
+    return "struct_mixer_ctrl_sz"
+  } else if (string == "mixer_devinfo_t") {
+    return "struct_mixer_devinfo_sz"
+  } else if (string == "mpu_command_rec") {
+    return "struct_mpu_command_rec_sz"
+  } else if (string == "rndstat_t") {
+    return "struct_rndstat_sz"
+  } else if (string == "rndstat_name_t") {
+    return "struct_rndstat_name_sz"
+  } else if (string == "rndctl_t") {
+    return "struct_rndctl_sz"
+  } else if (string == "rnddata_t") {
+    return "struct_rnddata_sz"
+  } else if (string == "rndpoolstat_t") {
+    return "struct_rndpoolstat_sz"
+  } else if (string == "rndstat_est_t") {
+    return "struct_rndstat_est_sz"
+  } else if (string == "rndstat_est_name_t") {
+    return "struct_rndstat_est_name_sz"
+  } else if (string == "pps_params_t") {
+    return "struct_pps_params_sz"
+  } else if (string == "pps_info_t") {
+    return "struct_pps_info_sz"
+  } else if (string == "linedn_t") {
+    return "(32 * sizeof(char))"
+  } else if (string == "mixer_info") {
+    return "struct_mixer_info_sz"
+  } else if (string == "RF_SparetWait_t") {
+    return "struct_RF_SparetWait_sz"
+  } else if (string == "RF_ComponentLabel_t") {
+    return "struct_RF_ComponentLabel_sz"
+  } else if (string == "RF_SingleComponent_t") {
+    return "struct_RF_SingleComponent_sz"
+  } else {
+    print "Unrecognized entry: " string
+    print "Aborting"
+    abnormal_exit = 1
+    exit 1
+  }
+
+  return string
+}
