#include <misc/helpers.h>

extern void real_mode_wrapper(void(*)());
extern void real_mode_testing(void);
extern void low_level_func(void);
extern void low_level_func_end(void);

void real_mode_init() {
    memcpy((uint8_t*)0x4000, (const uint8_t*)low_level_func,
           (uint32_t)((const uint8_t*)low_level_func_end - (const uint8_t*)low_level_func));
}

int kmain() {
    INFO("Hello, World!");

    real_mode_init();
    real_mode_wrapper(real_mode_testing);

    INFO("Hello, World!");
    unsigned short* video_memory = (unsigned short*)0xb8000;
    *video_memory = 0x5f4f;
    return 0;
}
