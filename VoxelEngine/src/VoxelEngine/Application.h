#pragma once

#include "Core.h"

#include "Window.h"

#include "VoxelEngine/LayerStack.h"

#include "Events/Event.h"
#include "VoxelEngine/Events/ApplicationEvent.h"

#include "VoxelEngine/Render/Shader.h"

#include "VoxelEngine/Render/Buffer.h"

namespace VoxelEngine
{
	class VOXELENGINE_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);

		inline Window& GetWindow() { return *m_Window; }

		static Application& Get() { return *s_Instance; }

	private:
		bool OnWindowClose(WindowCloseEvent& e);

		std::unique_ptr<Window> m_Window;
		bool m_Running = true;
		LayerStack m_LayerStack;

		uint32_t m_VertexArray;
		std::unique_ptr<Shader> m_Shader;
		std::unique_ptr<VertexBuffer> m_VertexBuffer;
		std::unique_ptr<IndexBuffer> m_IndexBuffer;

	private:
		static Application* s_Instance;
	};

	Application* CreateApplication();
}