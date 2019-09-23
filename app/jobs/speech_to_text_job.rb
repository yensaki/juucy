require 'open-uri'
require "google/cloud/speech"

class SpeechToTextJob < ApplicationJob
  queue_as :default

  def perform(audio)
    audio.update!(words: audio.speech_to_text!)
  end
end
