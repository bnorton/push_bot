# PushBot

PushBot is the Ruby Gem for connecting to the PushBots push notification service 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'push_bot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install push_bot

## Usage

#### Configuration
```ruby
# config/initializers/push_bot.rb

PushBot.configure do |config|
  config.id = 'Your Application ID'
  config.secret = 'Your Application Secret'
end
```

#### Register a Device Token
```ruby
# push token is the token given my the phone's OS
# platform is :ios or :android

device = PushBot::Device.new('USER TOKEN', :ios)
device = PushBot::Device.new(user.push_token, user.platform)
device.add
```

####Push a notification to a token
```ruby
push = PushBot::Push.new(user.push_token, user.platform)
push.notify('Hello and Welcome to the App!')
```

#### Register a Device Token to an alias
```ruby
# push token is the token given my the phone's OS
# platform is :ios or :android

device = PushBot::Device.new(user.push_token, user.platform)
device.add(:alias => user.email)
```

####Push a notification to an alias
```ruby
push = PushBot::Push.new(nil, user.platform)
push.notify('Hello and Welcome to the App!', :alias => user.email)
```

####Device Info
```ruby
device = PushBot::Device.new(user.push_token, user.platform)
device.info
```
