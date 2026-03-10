#pragma once

#include "types.h"

void outb(uint16_t port, uint8_t value);

uint8_t inb(uint16_t port); 

uint16_t inw(uint16_t port);

void hlt();

void putch(uchar_t c);

void puts(uchar_t* str,...);

void puts_with_va(uchar_t* str, va_list ptr);

uint64_t pow(uint64_t base, uint64_t power);

uint64_t len(uint64_t q, uint64_t n, uint64_t base);

BYTE *memcpy(BYTE *dest, const BYTE *src, uint32_t bytes);

bool_t memcmp(BYTE *p1, BYTE *p2, uint32_t bytes);

uint32_t strlen(uchar_t *p);

void *memset(void *p, BYTE val, uint64_t bytes);

WORD *memsetw(WORD *p, WORD val, uint32_t words);

void init_real_mode(void);

void puts(uchar_t* str,...);

void DEBUG(uchar_t *str,...);

void INFO(uchar_t *str,...);

void ERROR(uchar_t *str,...);