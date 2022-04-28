#ifndef LIQUID_USAGE_H
#define LIQUID_USAGE_H

#include "liquid.h"
#include <rice/rice.hpp>

extern "C"
void liquid_define_usage(void);
void usage_increment(const char *name);

#endif
