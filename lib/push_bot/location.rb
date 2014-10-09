module PushBot
  class Location
    attr_reader :lat, :lng

    def initialize(lat, lng)
      @lat = lat
      @lng = lng
    end

    def self.parse(*location)
      location.flatten!

      return location if location.size == 2
      location = location.first

      return [location.lat, location.lng] if location.respond_to?(:lat) && location.respond_to?(:lng)
      return [location.lat, location.lon] if location.respond_to?(:lat) && location.respond_to?(:lon)

      [location.latitude, location.longitude] if location.respond_to?(:latitude) && location.respond_to?(:longitude)
    end
  end
end
