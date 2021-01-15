// Boot loader
#include <SoC.h>
#include <cpu.h>

// Receive byte from UART (blocking)
uint32_t getByte()
{
  while (!cpuUartCanGet()) {}
  return cpuUartGet();
}

// Receive 32-bit word from UART (blocking)
uint32_t getWord()
{
  uint32_t w;
  w = getByte();
  w |= getByte() << 8;
  w |= getByte() << 16;
  w |= getByte() << 24;
  return w;
}

// Send byte over UART (blocking)
void putByte(uint32_t byte)
{
  while (!cpuUartCanPut()) {}
  cpuUartPut(byte);
}

// Write instruction to SIMT core
void writeInstrToSIMTCore(uint32_t addr, uint32_t instr)
{
  while (! cpuSIMTCanPut()) {}
  cpuSIMTWriteInstr(addr, instr);
}

// Boot loader
int main()
{
  // Receive code from host (blocking)
  while (1) {
    uint32_t addr = getWord();
    if (addr == 0xffffffff) break;
    uint32_t data = getWord();
    cpuWriteInstr(addr, data);
    writeInstrToSIMTCore(addr, data);
  }

  // Receive data from host (blocking)
  while (1) {
    uint32_t addr = getWord();
    if (addr == 0xffffffff) break;
    uint32_t data = getWord();
    volatile uint32_t* ptr = (uint32_t*) addr;
    *ptr = data;
  }

  // Perform cache flush so data is visible globally, e.g. to SIMT core
  cpuCacheFlushFull();

  // Determine boot mode
  uint32_t mode = getByte();
  if (mode == 0) {
    // CPU mode
    // --------

    // This is the common mode

    // Call the application's main function
    int (*appMain)() = (int (*)()) (MaxBootImageBytes);
    appMain();

    // Send terminating null to host
    putByte('\0');
  }
  else {
    // SIMT mode 
    // ---------

    // This mode is intended for running assembley tests on the SIMT core

    // Start kernel on SIMT core
    while (! cpuSIMTCanPut()) {}
    cpuSIMTStartKernel(MaxBootImageBytes);

    // Wait for kernel response
    while (!cpuSIMTCanGet()) {}
    int resp = cpuSIMTGet();

    // Send kernel response to host
    putByte(resp);
  }

  // Restart boot loader
  asm volatile("jr zero");

  // Unreachable
  return 0;
}
