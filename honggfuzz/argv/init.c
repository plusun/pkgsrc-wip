#include <sys/types.h>
#include <sys/exec.h>
#include <sys/sysctl.h>

#include <stdio.h>
#include <dlfcn.h>
#include <unistd.h>
#include <stdlib.h>
#include <err.h>
#include <string.h>
#include <assert.h>

static const char *xpathname;
static char xargv[4000];
static char xenvp[4000];
static char *first;
static char path[400];
static size_t len;

static void
GetArgsAndEnv(void)
{
	size_t nargv, nenv;

	int argvmib[4] = {CTL_KERN, KERN_PROC_ARGS, getpid(), KERN_PROC_ARGV};
	int envmib[4] = {CTL_KERN, KERN_PROC_ARGS, getpid(), KERN_PROC_ENV};

	if (sysctl(argvmib, 4, NULL, &nargv, NULL, 0) == -1) {
		errx(EXIT_FAILURE, "sysctl KERN_PROC_NARGV failed");
	}
	if (sysctl(envmib, 4, NULL, &nenv, NULL, 0) == -1) {
		errx(EXIT_FAILURE, "sysctl KERN_PROC_NENV failed");
	}
	if (sysctl(argvmib, 4, &xargv, &nargv, NULL, 0) == -1) {
		errx(EXIT_FAILURE, "sysctl KERN_PROC_ARGV failed");
	}
	if (sysctl(envmib, 4, &xenvp, &nenv, NULL, 0) == -1) {
		err(EXIT_FAILURE, "sysctl KERN_PROC_ENV failed");
	}
}

static void
GetPathname(void)
{
	xpathname = "/proc/self/exe";

	static const int name[] = {
		CTL_KERN, KERN_PROC_ARGS, -1, KERN_PROC_PATHNAME,
	};

	len = sizeof(path);
	if (sysctl(name, __arraycount(name), path, &len, NULL, 0) != -1)
		xpathname = path;
}


static void
ReExec(void)
{
        char *from_honggfuzz;
        uint8_t *buf;
        size_t len;
        extern void HF_ITER(uint8_t** buf, size_t* len);
        HF_ITER(&buf, &len);
        from_honggfuzz = (char*)buf;
	GetPathname();

	// strlcpy(from_honggfuzz, "REPLACED", 100);

	int ret = execl(xpathname, xargv, from_honggfuzz, NULL);
	err(EXIT_FAILURE, "execve");
	/* NOTREACHED */
}

void
_libc_init(void)
{
	void *(*original)(void);

	GetArgsAndEnv();

	for (first = xargv; *first; first++)
		continue;
	first++;
	
        if (strcmp(first, "REPLACEME") == 0) {
		ReExec();
		/* NOTREACHED */
	}
	original = dlsym(RTLD_NEXT, "_libc_init");
	(*original)();
}
