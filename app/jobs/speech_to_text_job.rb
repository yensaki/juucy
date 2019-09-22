require 'open-uri'
require "google/cloud/speech"

class SpeechToTextJob < ApplicationJob
  queue_as :default

  def perform(audio)
    file = open(audio.file.blob.service_url)
    # wavdir = File.join(Dir.tmpdir, audio.movie.uuid, 'audio')
    # FileUtils.mkdir_p(wavdir)
    # wavpath = File.join(wavdir, "#{audio.id}.wav")
    # Open3.capture3("ffmpeg -i '#{file.path}' -vn -ac 1 -ar 44100 -acodec pcm_s16le -f wav #{wavpath}")
    # audio.update!(file: {io: File.open(wavpath), filename: "#{audio.id}.wav"})

    ENV["GOOGLE_APPLICATION_CREDENTIALS"] =  Rails.root.join("./saki-185412-1b5c53d43eb9.json").to_s

    @speech = Google::Cloud::Speech.new

    config = {
      encoding: :LINEAR16,
      sample_rate_hertz: 16000,
      language_code: "ja-JP"
    }
    # wav 前提になっているので要修正
    speech_audio  = { uri: audio.file.blob.service_url }

    operation = @speech.long_running_recognize config, speech_audio

    puts "Operation started"

    operation.wait_until_done!

    raise operation.results.message if operation.error?

    results = operation.response.results

    @words = results.first.alternatives.map {|alternatives| alternatives.transcript}.join(' ')
    audio.update!(words: @words)
  end
end
