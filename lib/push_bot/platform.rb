module PushBot
  class Platform
    VALUES = %w(ios android)

    def self.parse(*platforms)
      platforms = platforms.flatten.map! {|p| VALUES.index(p.to_s.downcase) }
      raise(ArgumentError, 'Platform must be ios or android') if platforms.any?(&:nil?)

      platforms.map!(&:to_s)
    end
  end
end
