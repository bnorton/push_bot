module PushBot
  class Config
    attr_accessor :id, :secret

    def self.config
      @config ||= new
    end

    def self.configure
      yield(config) if block_given?

      config
    end
  end
end
