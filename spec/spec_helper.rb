ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|

  config.after(:each) do

    Person.all().each() do |person|
      person.destroy()
    end

    Family.all().each() do |parent|
      parent.destroy()
    end
    end
end
