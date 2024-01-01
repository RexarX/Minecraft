#pragma once

#include "Events/Event.h"

namespace VoxelEngine
{
	class __declspec(dllexport) Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();
	};

	Application* CreateApplication();
}