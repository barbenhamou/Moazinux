#pragma once

#include "types.h"

void outb(uint16_t port, uint8_t value);

uint8_t inb(uint16_t port); 

uint16_t inw(uint16_t port);

void hlt();

void putch(uchar c);

void puts(uchar* str,...);

void puts_with_va(uchar* str, va_list ptr);

uint64_t pow(uint64_t base, uint64_t power);

uint64_t len(uint64_t q, uint64_t n, uint64_t base);

uint8_t *memcpy(uint8_t *dest, const uint8_t *src, uint32_t bytes);

bool_t memcmp(uint8_t *p1, uint8_t *p2, uint32_t bytes);

uint32_t strlen(uchar *p);

void *memset(void *p, uint8_t val, uint64_t bytes);

uint16_t *memsetw(uint16_t *p, uint16_t val, uint32_t words);

void init_real_mode(void);

void puts(uchar* str,...);

void DEBUG(uchar *str,...);

void INFO(uchar *str,...);

void ERROR(uchar *str,...);