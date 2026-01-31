#include "audio/AudioEngine.h"

AudioEngine::AudioEngine()
{
    setAudioChannels (0, 2); // input=0, output=2 (stereo)
}

AudioEngine::~AudioEngine()
{
    shutdownAudio();
}

void AudioEngine::prepareToPlay (int samplesPerBlockExpected, double sampleRate)
{
    juce::dsp::ProcessSpec spec;
    spec.sampleRate = sampleRate;
    spec.maximumBlockSize = (juce::uint32) samplesPerBlockExpected;
    spec.numChannels = 2;

    osc.initialise([](float x) { return std::sin(x); }, 128);
    osc.prepare(spec);
    osc.setFrequency(110.0f); // A2

    gain.prepare(spec);
    gain.setGainLinear(0.05f);
}

void AudioEngine::getNextAudioBlock (const juce::AudioSourceChannelInfo& bufferToFill)
{
    bufferToFill.clearActiveBufferRegion();

    if (!testToneEnabled) return;

    juce::dsp::AudioBlock<float> block (*bufferToFill.buffer,
                                        (size_t) bufferToFill.startSample);
    block = block.getSubBlock(0, (size_t) bufferToFill.numSamples);

    osc.process(juce::dsp::ProcessContextReplacing<float>(block));
    gain.process(juce::dsp::ProcessContextReplacing<float>(block));
}

void AudioEngine::releaseResources()
{
}
