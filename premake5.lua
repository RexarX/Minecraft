workspace "Minecraft"
	architecture "x64"

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

include "VoxelEngine/vendor/GLFW"
include "VoxelEngine/vendor/GLAD"
include "VoxelEngine/vendor/ImGui"

project "VoxelEngine"
	location "VoxelEngine"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "vepch.h"
	pchsource "VoxelEngine/src/vepch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.GLAD}",
		"%{IncludeDir.ImGui}"
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
		"VoxelEngine/src"
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