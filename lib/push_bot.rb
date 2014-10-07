require 'forwardable'

require 'push_bot/api'
require 'push_bot/config'
require 'push_bot/device'
require 'push_bot/location'
require 'push_bot/platform'
require 'push_bot/push'
require 'push_bot/request'
require 'push_bot/response'
require 'push_bot/tag'

module PushBot
  def self.configure(&block)
    Config.configure(&block)
  end
end
