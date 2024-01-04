workspace "Minecraft"
	architecture "x64"
	startproject "Minecraft"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "VoxelEngine/vendor/GLFW/include"
IncludeDir["GLAD"] = "VoxelEngine/vendor/GLAD/include"
IncludeDir["ImGui"] = "VoxelEngine/vendor/imgui"
IncludeDir["glm"] = "VoxelEngine/vendor/glm"

include "VoxelEngine/vendor/GLFW"
include "VoxelEngine/vendor/GLAD"
include "VoxelEngine/vendor/ImGui"

project "VoxelEngine"
	location "VoxelEngine"
	kind "SharedLib"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "vepch.h"
	pchsource "VoxelEngine/src/vepch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.GLAD}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}"
	}

	links 
	{ 
		"GLFW",
		"GLAD",
		"ImGui",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++20"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"VE_PLATFORM_WINDOWS",
			"VE_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Minecraft")
		}

	filter "configurations:Debug"
		defines "VE_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "VE_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "VE_DIST"
		optimize "On"

project "Minecraft"
	location "Minecraft"
	kind "ConsoleApp"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"VoxelEngine/vendor/spdlog/include",
		"VoxelEngine/src",
		"%{IncludeDir.glm}"
	}

	links
	{
		"VoxelEngine"
	}

	filter "system:windows"
		cppdialect "C++20"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"VE_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "VE_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "VE_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "VE_DIST"
		optimize "On"
