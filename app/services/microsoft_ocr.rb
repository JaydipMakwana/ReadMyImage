require 'net/http'

class MicrosoftOcr
  # #
  # def initialize(image)
  #   @image = image
  # end
  def self.call_service(image)
    uri = URI('https://westcentralus.api.cognitive.microsoft.com/vision/v2.0/ocr')
    uri.query = URI.encode_www_form({
        # Request parameters
        'language' => 'en',
    })
    request = Net::HTTP::Post.new(uri.request_uri)
    # Request headers
    request['Content-Type'] = 'application/octet-stream'
    # Request headers
    request['Ocp-Apim-Subscription-Key'] = '33f1f6f4a4e54cfcbf9e36b63a1c06fe'
    # Request body
    binary = image.download
    request.body = binary
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end
    return format_response(JSON.parse(response.body))
  end

  def self.format_response(response)
    lines = []
    line = []
    response['regions'].select {|re| re['lines'].select {|li| lines << li['words'].pluck('text')}}
    lines.select { |l| line << l.join(' ') }
    line.join("\n")
  end
end
