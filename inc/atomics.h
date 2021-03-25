#ifndef _ATOMICS_H_
#define _ATOMICS_H_

// Atomic swap
INLINE int atomicSwap(volatile int *ptr, int val) {
  int x;
  __atomic_exchange(ptr, &val, &x, __ATOMIC_RELAXED);
  return x;
}

// Atomic add
INLINE int atomicAdd(volatile int *ptr, int val) {
  return __atomic_fetch_add(ptr, val, __ATOMIC_RELAXED);
}

// Atomic and
INLINE int atomicAnd(volatile int *ptr, int val) {
  return __atomic_fetch_and(ptr, val, __ATOMIC_RELAXED);
}

// Atomic or
INLINE int atomicOr(volatile int *ptr, int val) {
  return __atomic_fetch_or(ptr, val, __ATOMIC_RELAXED);
}

// Atomic xor
INLINE int atomicXor(volatile int *ptr, int val) {
  return __atomic_fetch_xor(ptr, val, __ATOMIC_RELAXED);
}

// Atomic max (signed)
INLINE int atomicMax(volatile int *ptr, int val) {
  int x;
  asm volatile("amomax.w %0, %1, 0(%2)" : "=r"(x) : "r"(val), "r"(ptr));
  return x;
}

// Atomic max (unsigned)
INLINE unsigned atomicMax(volatile unsigned *ptr, unsigned val) {
  int x;
  asm volatile("amomaxu.w %0, %1, 0(%2)" : "=r"(x) : "r"(val), "r"(ptr));
  return x;
}

// Atomic max (signed)
INLINE int atomicMin(volatile int *ptr, int val) {
  int x;
  asm volatile("amomin.w %0, %1, 0(%2)" : "=r"(x) : "r"(val), "r"(ptr));
  return x;
}

// Atomic max (unsigned)
INLINE unsigned atomicMin(volatile unsigned *ptr, unsigned val) {
  int x;
  asm volatile("amominu.w %0, %1, 0(%2)" : "=r"(x) : "r"(val), "r"(ptr));
  return x;
}

#endif
