module PushBot
  class Response
    extend Forwardable

    attr_reader :raw_response, :error

    def initialize
      @raw_response = yield
    rescue => e
      @error = e
    end

    def inspect
      "#<#{self.class}:#{object_id} @success=#{success?} @json=#{json}>"
    end

    # Did the request complete successfully or have issues
    delegate :success? => :raw_response

    # The raw response body string
    delegate :body => :raw_response

    # Did the response complete with an error
    def error?
      defined?(@error) && @error
    end

    # The result of the request as a JSON Object
    #
    # @return [Hash, Array] the JSON Object
    def json
      @json ||= body.present? ? JSON.parse(body) : {}
    end
  end
end
