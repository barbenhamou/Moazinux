#include <misc/helpers.h>

int kmain() {
    INFO("Hello, World!");

    unsigned short* video_memory = (unsigned short*)0xb8000;
    *video_memory = 0x5f4f;
    return 0;
}