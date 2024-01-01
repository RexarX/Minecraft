#include "VoxelEngine.h"

class Minecraft : public VoxelEngine::Application
{
public:
	Minecraft()
	{

	}

	~Minecraft()
	{

	}
};

VoxelEngine::Application* VoxelEngine::CreateApplication()
{
	return new Minecraft();
}