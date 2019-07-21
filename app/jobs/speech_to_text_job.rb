require 'open-uri'
require "google/cloud/speech"

class SpeechToTextJob < ApplicationJob
  queue_as :default

  def perform(audio)
    file = open(audio.file.blob.service_url)
    wavdir = File.join(Dir.tmpdir, audio.movie.uuid, 'audio')
    FileUtils.mkdir_p(wavdir)
    wavpath = File.join(wavdir, "#{audio.id}.wav")
    Open3.capture3("ffmpeg -i '#{file.path}' -vn -ac 1 -ar 44100 -acodec pcm_s16le -f wav #{wavpath}")

    ENV["GOOGLE_APPLICATION_CREDENTIALS"] =  Rails.root.join("./saki-185412-1b5c53d43eb9.json").to_s

    @speech = Google::Cloud::Speech.new

    audio_file = File.binread(wavpath)

    config = {
      encoding: :LINEAR16,
      language_code: "ja-JP"
    }
    audio  = { content: audio_file }
    response = @speech.recognize(config, audio)
    results = response.results

    puts results.inspect

    @words = results.first.alternatives.map {|alternatives| alternatives.transcript}
    audio.update!(words: @words)
  end
end
