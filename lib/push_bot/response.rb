module PushBot
  class Response
    attr_reader :raw_response, :error

    def initialize(request)
      @raw_response = request.run

      @success = raw_response.success?
    rescue => e
      @error = e
    end

    def inspect
      "#<#{self.class}:#{object_id} @success=#{success?} @json=#{json}>"
    end

    # Did the request complete successfully or have issues
    def success?
      defined?(@success) && @success
    end

    # Did the response complete with an error
    def error?
      defined?(@error) && @error
    end

    # The raw response body string
    def body
      raw_response.try(:body)
    end

    # The result of the request as a JSON Object
    #
    # @return [Hash, Array] the JSON Object
    def json
      @json ||= body.present? ? JSON.parse(body) : {}
    end
  end
end
