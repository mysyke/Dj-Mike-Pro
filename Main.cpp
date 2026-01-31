#include <JuceHeader.h>
#include "audio/AudioEngine.h"

class MainWindow : public juce::DocumentWindow
{
public:
    MainWindow() : juce::DocumentWindow("DJ Mike Pro",
                                        juce::Colours::black,
                                        juce::DocumentWindow::allButtons)
    {
        setUsingNativeTitleBar(true);

        engine = std::make_unique<AudioEngine>();
        setContentOwned(engine.get(), false);

        centreWithSize(1200, 720);
        setVisible(true);
    }

    void closeButtonPressed() override
    {
        juce::JUCEApplication::getInstance()->systemRequestedQuit();
    }

private:
    std::unique_ptr<AudioEngine> engine;
};

class DJMikeProApp : public juce::JUCEApplication
{
public:
    const juce::String getApplicationName() override       { return "DJ Mike Pro"; }
    const juce::String getApplicationVersion() override    { return "0.1.0"; }
    void initialise(const juce::String&) override          { mainWindow = std::make_unique<MainWindow>(); }
    void shutdown() override                               { mainWindow.reset(); }

private:
    std::unique_ptr<MainWindow> mainWindow;
};

START_JUCE_APPLICATION(DJMikeProApp)
