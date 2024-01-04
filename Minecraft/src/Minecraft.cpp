#include <VoxelEngine.h>

class GameLayer : public VoxelEngine::Layer
{
public:
	GameLayer()
		: Layer("Game")
	{
	}

	void OnUpdate() override
	{
		VE_INFO("Game::Update");
	}

	void OnEvent(VoxelEngine::Event& event) override
	{
		VE_TRACE("{0}", event);
	}
};

class Minecraft : public VoxelEngine::Application
{
public:
	Minecraft()
	{
		PushLayer(new GameLayer());
		//PushOverlay(new VoxelEngine::ImGuiLayer());
	}

	~Minecraft()
	{

	}
};

VoxelEngine::Application* VoxelEngine::CreateApplication()
{
	return new Minecraft();
}