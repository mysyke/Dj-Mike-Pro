#pragma once
#include <JuceHeader.h>

class AudioEngine : public juce::AudioAppComponent
{
public:
    AudioEngine();
    ~AudioEngine() override;

    void prepareToPlay (int samplesPerBlockExpected, double sampleRate) override;
    void getNextAudioBlock (const juce::AudioSourceChannelInfo& bufferToFill) override;
    void releaseResources() override;

    void setTestToneEnabled(bool enabled) { testToneEnabled = enabled; }

private:
    juce::dsp::Oscillator<float> osc;
    juce::dsp::Gain<float> gain;
    bool testToneEnabled = true;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (AudioEngine)
};
