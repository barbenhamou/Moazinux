#pragma once

typedef unsigned long long QWORD;
typedef unsigned long long uint64_t;
typedef unsigned int DWORD;
typedef unsigned int uint32_t;
typedef unsigned short WORD;
typedef unsigned short uint16_t;
typedef unsigned char BYTE;
typedef unsigned char uchar_t;
typedef unsigned char uint8_t;
typedef BYTE bool_t;

#define NULL 0
#define TRUE 1
#define FALSE 0

#define va_list __builtin_va_list
#define va_start(p1, p2) __builtin_va_start(p1, p2)
#define va_end(p) __builtin_va_end(p)
#define va_arg(p1, p2) __builtin_va_arg(p1, p2)