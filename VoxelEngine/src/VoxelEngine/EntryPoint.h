#pragma once

extern VoxelEngine::Application* VoxelEngine::CreateApplication();

int main(int argc, char** argv)
{
	VoxelEngine::Log::initialize();

	auto app = VoxelEngine::CreateApplication();
	app->Run();
	delete app;

	return 0;
}