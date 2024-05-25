#ifndef MEM_H
#define MEM_H

#include <sys/sysctl.h>
#include <stdio.h>

struct mem
{
    int mem_free;
    int mem_used;
};

static inline void mem_init(struct mem *mem)
{
    // No initialization required for memory monitoring
}

static inline void mem_update(struct mem *mem)
{
    int mib[2];
    uint64_t total_memory, free_memory, used_memory;
    size_t length;

    // Get total physical memory
    mib[0] = CTL_HW;
    mib[1] = HW_MEMSIZE;
    length = sizeof(total_memory);
    sysctl(mib, 2, &total_memory, &length, NULL, 0);

    // Get free memory
    mib[0] = CTL_HW;
    mib[1] = HW_USERMEM;
    length = sizeof(free_memory);
    sysctl(mib, 2, &free_memory, &length, NULL, 0);

    // Calculate used memory
    used_memory = total_memory - free_memory;

    // Convert to MB
    mem->mem_free = free_memory / (1024 * 1024);
    mem->mem_used = used_memory / (1024 * 1024);
}

#endif // MEM_H