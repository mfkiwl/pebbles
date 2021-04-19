#include <nocl.h>

// Kernel for computing the parallel prefix sum (inclusive scan)
// Simple (non-work-efficient) version based on one from "GPU Gems 3"
struct Scan : Kernel {
  int len;
  int *in, *out;

  void kernel() {
    // Shared arrays
    int* tempIn = shared.alloc<int>(blockDim.x);
    int* tempOut = shared.alloc<int>(blockDim.x);

    // Shorthand for local thread id
    int t = threadIdx.x;

    for (int x = 0; x < len; x += blockDim.x) {
      // Load data
      tempOut[t] = in[x+t];
      __syncthreads();

      // Local scan
      for (int offset = 1; offset < blockDim.x; offset <<= 1) {
        swap(tempIn, tempOut);
        if (t >= offset)
          tempOut[t] = tempIn[t] + tempIn[t - offset];
        else
          tempOut[t] = tempIn[t];
        __syncthreads();
      }

      // Store data
      int acc = x > 0 ? out[x-1] : 0;
      out[x+t] = tempOut[t] + acc;
    }
  }
};

int main()
{
  // Vector size for benchmarking
  // Should divide evenly by SIMT thread count
  int N = 4096;

  // Input and output vectors
  simt_aligned int in[N], out[N];

  // Initialise inputs
  for (int i = 0; i < N; i++) in[i] = i;

  // Instantiate kernel
  Scan k;

  // Use a single block of threads
  k.blockDim.x = SIMTWarps * SIMTLanes;

  // Assign parameters
  k.len = N;
  k.in = in;
  k.out = out;

  // Invoke kernel
  noclRunKernel(&k);

  // Check result
  bool ok = true;
  int acc = 0;
  for (int i = 0; i < N; i++) {
    acc += i;
    ok = ok && out[i] == acc;
  }

  // Display result
  puts("Self test: ");
  puts(ok ? "PASSED" : "FAILED");
  putchar('\n');

  return 0;
}