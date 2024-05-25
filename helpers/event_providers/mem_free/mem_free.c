#include "mem.h"
#include "../sketchybar.h"

int main(int argc, char **argv)
{
    float update_freq;
    if (argc < 3 || (sscanf(argv[2], "%f", &update_freq) != 1))
    {
        printf("Usage: %s \"<event-name>\" \"<event_freq>\"\n", argv[0]);
        exit(1);
    }

    alarm(0);
    struct mem memory;
    mem_init(&memory);

    // Setup the event in SketchyBar
    char event_message[512];
    snprintf(event_message, 512, "--add event '%s'", argv[1]);
    sketchybar(event_message);

    char trigger_message[512];
    for (;;)
    {
        // Acquire new info
        mem_update(&memory);

        // Prepare the event message
        snprintf(trigger_message,
                 512,
                 "--trigger '%s' mem_free='%d' mem_used='%d'",
                 argv[1],
                 memory.mem_free,
                 memory.mem_used);

        // Trigger the event
        sketchybar(trigger_message);

        // Wait
        usleep(update_freq * 1000000);
    }
    return 0;
}