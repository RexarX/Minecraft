#pragma once

#include "Core.h"

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