require "google/cloud/speech"

class Audio < ApplicationRecord
  belongs_to :movie

  has_one_attached :file

  def speech_to_text!
    speech_client = Google::Cloud::Speech.new

    config = {
      encoding: :LINEAR16,
      sample_rate_hertz: 48000,
      language_code: "ja-JP"
    }
    speech_audio  = { uri: "gs://yensaki_juucy_dev/#{file.blob.key}" }

    operation = speech_client.long_running_recognize(config, speech_audio)
    operation.wait_until_done!

    raise operation.results.message if operation.error?
    operation.response.results.first&.alternatives&.compact&.map(&:transcript)&.join(' ')
  end
end
