module PushBot
  class Device < Api
    # Request a list of your registered devices
    #
    # @return {PushBot::Response}
    def all
      request.get(:all)
    end

    # Add a specific user or batch of users to PushBots
    #
    # @param registration_options Any of the options available {https://pushbots.com/developer/rest Rest Docs @ PushBots}
    # @return {PushBot::Response}
    def add(registration_options={})
      raise(ArgumentError, 'Batch device add should only be to a single platform') if Array === token && platforms.size != 1

      options, type = registration_options.merge(
        :platform => platform
      ), :batch

      if user? && !(Array === token)
        type = nil
        options[:token] = token
      else
        options[:tokens] = token
      end

      request.put(type, options)
    end

    # Retrieve information about the device with this token
    #
    # @return {PushBot::Response}
    def info
      request.get(:one, :token => token)
    end

    def removed
      Request.new(:feedback).get
    end

    # Remove a specific user from PushBots
    #
    # @return {PushBot::Response}
    def remove
      raise(ArgumentError, 'A token and platform is required for removal') unless token && token

      request.put(:del, :token => token, :platform => platform)
    end

    private

    def request
      Request.new(:deviceToken)
    end
  end
end
