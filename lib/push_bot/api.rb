module PushBot
  class Api
    attr_accessor :token, :platforms, :platform

    # Create a new Api object with an associated token and platform
    #
    # @param token the user identifier for your platform
    # @param platform one of `:ios` or `:android` to indicate which platform the user uses
    def initialize(token, platform)
      @token = token
      @platforms = Platform.parse(platform)
      @platform = platforms.first
    end

    # Does this request represent a tokened single user or is it a batch request
    def token?
      (defined?(@token) && @token) ? true : false
    end

    # Does this request apply to a single user
    def user?
      token?
    end

    # Does this batch apply to a segment
    def batch?
      !token?
    end
  end
end
