#include <VoxelEngine.h>

//std::shared_ptr<spdlog::logger> VoxelEngine::Log::s_CoreLogger;
//std::shared_ptr<spdlog::logger> VoxelEngine::Log::s_ClientLogger;

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