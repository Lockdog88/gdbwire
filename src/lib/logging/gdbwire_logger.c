#define CLOG_MAIN
#include "logging/clog.h"

#include "logging/gdbwire_logger.h"

static const int GDBWIRE_LOGGER = 0;

static enum clog_level
convert_to_clog_level(enum gdbwire_logger_level level)
{
    enum clog_level clevel;

    switch (level) {
        case GDBWIRE_LOGGER_DEBUG:
            clevel = CLOG_DEBUG;
            break;
        case GDBWIRE_LOGGER_INFO:
            clevel = CLOG_INFO;
            break;
        case GDBWIRE_LOGGER_WARN:
            clevel = CLOG_WARN;
            break;
        case GDBWIRE_LOGGER_ERROR:
            clevel = CLOG_ERROR;
            break;
    }

    return clevel;
}

int
gdbwire_logger_open(const char *path)
{
    int result = -1;
    int fd = open(path, O_CREAT | O_WRONLY | O_TRUNC,
            S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if (fd != -1) {
        result = clog_init_fd(GDBWIRE_LOGGER, fd);
        if (result != 0) {
            result = -1;
        }
    }
    return result;
}

void
gdbwire_logger_close()
{
    clog_free(GDBWIRE_LOGGER);
}

int
gdbwire_logger_set_level(enum gdbwire_logger_level level)
{
    int result = clog_set_level(GDBWIRE_LOGGER, convert_to_clog_level(level));
    if (result != 0) {
        result = -1;
    }
    return result;
}

void
gdbwire_logger_log(const char *file, int line, enum gdbwire_logger_level level,
        const char *fmt, ...)
{
    enum clog_level clevel = convert_to_clog_level(level);
    va_list ap;
    va_start(ap, fmt);

    _clog_log(file, line, (enum clog_level)level, GDBWIRE_LOGGER, fmt, ap);
}
