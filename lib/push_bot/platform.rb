module PushBot
  class Platform
    VALUES = %w(ios android)

    # Translate an array of :ios / :android into an array of integer strings
    #
    # @param platforms any of `:ios` and `:android`
    # @return Array[<String>]
    def self.parse(*platforms)
      platforms = platforms.flatten.map! {|p| VALUES.index(p.to_s.downcase) }
      raise(ArgumentError, 'Platform must be ios or android') if platforms.any?(&:nil?)

      platforms.map!(&:to_s)
    end
  end
end
