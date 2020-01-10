require 'net/http'

class GoogleCloudVision
  def self.get_text(image)
    uri = URI('https://vision.googleapis.com/v1/images:annotate?key=AIzaSyCuSUigh-V26LftrrHy9gZm0vsGJEOucx4')
    base64_img = Base64.encode64(image.download)

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request.body = {"requests": [{ "image": { "content": base64_img }, "features": [{ "type": "DOCUMENT_TEXT_DETECTION" }]}]}.to_json
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end
    

    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      return format_response(JSON.parse(response.body))
    else
      response.value
    end
  end

  def self.format_response(response)
    response["responses"].first["fullTextAnnotation"]["text"]
  end

  def self.classify_text(text)
    uri = URI('https://language.googleapis.com/v1/documents:annotateText?key=AIzaSyCuSUigh-V26LftrrHy9gZm0vsGJEOucx4')

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request.body = {
                    "document": {
                      "type": "PLAIN_TEXT",
                      "content": text
                    },
                    "features": {
                      "extractEntitySentiment": "TRUE"
                    },
                    "encodingType": "NONE"
                  }.to_json

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end
    # binding.pry
  end
end
# "extractEntities": "TRUE",
# "extractDocumentSentiment": "TRUE",
# "extractEntitySentiment": "TRUE",
# "classifyText": "TRUE"
