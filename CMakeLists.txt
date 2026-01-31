cmake_minimum_required(VERSION 3.21)
project(DJMikePro VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)

# Fetch JUCE at configure time (no submodules needed)
FetchContent_Declare(
  juce
  GIT_REPOSITORY https://github.com/juce-framework/JUCE.git
  GIT_TAG 8.0.1
)
FetchContent_MakeAvailable(juce)

juce_add_gui_app(DJMikePro
    PRODUCT_NAME "DJ Mike Pro"
)

target_sources(DJMikePro PRIVATE
    Source/Main.cpp
    Source/audio/AudioEngine.cpp
)

target_include_directories(DJMikePro PRIVATE Source)

target_compile_definitions(DJMikePro PRIVATE
    JUCE_WEB_BROWSER=0
    JUCE_USE_CURL=0
)

target_link_libraries(DJMikePro PRIVATE
    juce::juce_gui_basics
    juce::juce_gui_extra
    juce::juce_audio_basics
    juce::juce_audio_devices
    juce::juce_audio_formats
    juce::juce_audio_processors
    juce::juce_dsp
)
