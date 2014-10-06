module PushBot
  class Push < Api
    # Push a new message to the Segment
    #
    # @param message The message to alert the user with
    # @param push_options Any of the options available {https://pushbots.com/developer/rest Rest Docs @ PushBots}
    # @return {PushBot::Response}
    def notify(message, push_options={})
      options = { :sound => '' }
      options, type = options.merge(push_options).merge(
        :msg => message,
        :platform => platforms
      ), :all

      unless batch?
        type = :one
        options[:badge] ||= '0'
        options[:token] = token
        options[:platform] = platform
      end

      Request.new(:push).post(type, options)
    end
  end
end
