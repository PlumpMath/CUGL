#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <math.h>
#include "Kernel.h"

//normal .cu file with int main() etc
//also with member functions to call kernels
//kernel::doKernel(float* data)
//{
//	kernel<<<grid, block>>>(data)
//}

__global__ void AddKernel(cudaSurfaceObject_t tex, dim3 dimentions)
{
	int x = blockIdx.x * blockDim.x + threadIdx.x;
	int y = blockIdx.y * blockDim.y + threadIdx.y;

	if(x >= dimentions.x || y >= dimentions.y)
	{
		return;
	}

	float4 element = make_float4(1.0f, 0.0f, 0.0f, 1.0f);
	surf2Dwrite(element, tex, x * sizeof(float4), y);	//undefined in .cu file
}

// int main()
// {
// 	
// }

void Kernel::ExecuteKernel(cudaSurfaceObject_t tex, dim3 dimentions)
{
	dim3 blockDim(128, 128, 1);
	dim3 gridDim(ceil((float)dimentions.x / (float)blockDim.x), ceil((float)dimentions.y / (float)blockDim.y), 1);
	//AddKernel << <gridDim, blockDim >> >(tex, dimentions);
}