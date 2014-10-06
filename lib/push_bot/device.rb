module PushBot
  class Device < Api
    # Add a specific user or batch of users to PushBots
    #
    # @param registration_options Any of the options available {https://pushbots.com/developer/rest Rest Docs @ PushBots}
    # @return {PushBot::Response}
    def add(registration_options={})
      raise(ArgumentError, 'Batch device add should only be to a single platform') if Array === token && platforms.size != 1

      options, type = registration_options.merge(
        :platform => platform
      ), :batch

      if user?
        type = nil
        options[:token] = token
      end

      Request.new(:deviceToken).put(type, options)
    end

    def info
      Request.new(:deviceToken).get(:one, :token => token)
    end

    # Remove a specific user from PushBots
    #
    # @return {PushBot::Response}
    def remove
      raise(ArgumentError, 'A token and platform is required for removal') unless token && token

      Request.new(:deviceToken).put(:del, :token => token, :platform => platform)
    end
  end
end
