# $Id: Makefile,v 1.185 2003/05/22 12:20:38 xtraeme Exp $
# $NetBSD: Makefile,v 1.185 2003/05/22 12:20:38 xtraeme Exp $

COMMENT=	WIP pkgsrc packages

SUBDIR+=	PPower4
SUBDIR+=	WEPCrack
SUBDIR+=	abook
SUBDIR+=	abuse_sdl
SUBDIR+=	adodb
SUBDIR+=	allegro
SUBDIR+=	amsn
SUBDIR+=	aolserver
SUBDIR+=	ap-bunzip2
SUBDIR+=	ap-ometer
SUBDIR+=	aputils
SUBDIR+=	autoproject
SUBDIR+=	bc
SUBDIR+=	bftpd
SUBDIR+=	billardgl
SUBDIR+=	bin86
SUBDIR+=	bugzilla
SUBDIR+=	byacc
SUBDIR+=	cherokee
SUBDIR+=	chksniff
SUBDIR+=	cjk-latex
SUBDIR+=	cjk-latex-chinese
SUBDIR+=	cjk-latex-japanese
SUBDIR+=	cjk-latex-korean
SUBDIR+=	cvsd
SUBDIR+=	dancer-ircd
SUBDIR+=	darkice
SUBDIR+=	defendguin
SUBDIR+=	devhelp
SUBDIR+=	dircproxy
SUBDIR+=	directfb
SUBDIR+=	dosbox
SUBDIR+=	drweb
SUBDIR+=	ed
SUBDIR+=	emirror
SUBDIR+=	ezbounce
SUBDIR+=	fluxconf
SUBDIR+=	fuse
SUBDIR+=	fuse-utils
SUBDIR+=	fwbuilder
SUBDIR+=	gdrdao
SUBDIR+=	geeklog
SUBDIR+=	geoip
SUBDIR+=	gimp-current
SUBDIR+=	gini
SUBDIR+=	gkrellm2
SUBDIR+=	gkrellm2-flynn
SUBDIR+=	gkrellm2-launch
SUBDIR+=	gkrellm2-leds
SUBDIR+=	gkrellm2-multiping
SUBDIR+=	gkrellm2-server
SUBDIR+=	gkrellm2-share
SUBDIR+=	gkrellm2-snmp
SUBDIR+=	gkrellm2-volume
SUBDIR+=	gkrellm2-xmms
SUBDIR+=	gmencoder
SUBDIR+=	gnomeicu
SUBDIR+=	gstreamer-player
SUBDIR+=	gtetrinet2
SUBDIR+=	gtk-sharp
SUBDIR+=	gtk2-engines-mist
SUBDIR+=	gtk2-engines-xfce
SUBDIR+=	gtranslator
SUBDIR+=	honeyd-arpd
SUBDIR+=	httrack
SUBDIR+=	ices
SUBDIR+=	icmpchat
SUBDIR+=	idesk
SUBDIR+=	idled
SUBDIR+=	ike-scan
SUBDIR+=	ion-devel
SUBDIR+=	ion-dock
SUBDIR+=	jabberd
SUBDIR+=	jakarta-log4j
SUBDIR+=	jdk-openjit
SUBDIR+=	jdk12
SUBDIR+=	jdk12-openjit
SUBDIR+=	jdk13
SUBDIR+=	jdk13-openjit
SUBDIR+=	jigdo
SUBDIR+=	jpgraph
SUBDIR+=	kgpg
SUBDIR+=	libdialog
SUBDIR+=	libfwbuilder
SUBDIR+=	libgsf
SUBDIR+=	libshout
SUBDIR+=	libspectrum
SUBDIR+=	libwpd
SUBDIR+=	linux-modutils
SUBDIR+=	linux-nfs-utils
SUBDIR+=	liquidwar
SUBDIR+=	mailfilter
SUBDIR+=	mcats
SUBDIR+=	mcats-iodbc
SUBDIR+=	mixer.tk
SUBDIR+=	mopac
SUBDIR+=	mtf
SUBDIR+=	multi-aterm
SUBDIR+=	muse
SUBDIR+=	nagios-base
SUBDIR+=	nagios-plugin-ldap
SUBDIR+=	nagios-plugin-mysql
SUBDIR+=	nagios-plugin-pgsql
SUBDIR+=	nagios-plugin-snmp
SUBDIR+=	nagios-plugins
SUBDIR+=	navigatrix
SUBDIR+=	net-tools
SUBDIR+=	netbeans-ide
SUBDIR+=	netkit-base
SUBDIR+=	newsx
SUBDIR+=	nvtv
SUBDIR+=	p5-Chart
SUBDIR+=	p5-Compress-Bzip2
SUBDIR+=	p5-CDDB
SUBDIR+=	p5-Data-TemporaryBag
SUBDIR+=	p5-GeoIP
SUBDIR+=	p5-HTTP-GHTTP
SUBDIR+=	p5-Net-Gnats
SUBDIR+=	p5-Net-Jabber
SUBDIR+=	p5-SWF-File
SUBDIR+=	p5-Unicode-String
SUBDIR+=	p5-XML-Stream
SUBDIR+=	p5-gtk2
SUBDIR+=	perltidy
SUBDIR+=	phplot
SUBDIR+=	pinball
SUBDIR+=	pixieplus
SUBDIR+=	poedit
SUBDIR+=	portmap
SUBDIR+=	ppp
SUBDIR+=	procps
SUBDIR+=	pts
SUBDIR+=	py-OpenGL
SUBDIR+=	py-PgSQL
SUBDIR+=	py-gnome2
SUBDIR+=	py-gnosis-utils
SUBDIR+=	py-spreadmodule
SUBDIR+=	py-twisted
SUBDIR+=	qinx
SUBDIR+=	qn-x11
SUBDIR+=	raptor
SUBDIR+=	rcorder
SUBDIR+=	rlpr
SUBDIR+=	scm
SUBDIR+=	scponly
SUBDIR+=	shoutcast
SUBDIR+=	srvx
SUBDIR+=	strace
SUBDIR+=	streamripper
SUBDIR+=	sysklogd
SUBDIR+=	sysvinit
SUBDIR+=	tendra
SUBDIR+=	tex-foiltex
SUBDIR+=	totem
SUBDIR+=	tsclient
SUBDIR+=	umix
SUBDIR+=	vcdgear
SUBDIR+=	vim-gtk2
SUBDIR+=	vixie-cron
SUBDIR+=	vmsbackup
SUBDIR+=	windowlab
SUBDIR+=	words
SUBDIR+=	xawtv
SUBDIR+=	xevil
SUBDIR+=	xml2doc
SUBDIR+=	xmms-liveice
SUBDIR+=	xplore
SUBDIR+=	zebra-pj
SUBDIR+=	vms-empire

.include "../mk/bsd.pkg.subdir.mk"
