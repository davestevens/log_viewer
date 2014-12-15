#!/usr/bin/env ruby
require "json"

KEY_VALUE_REGEX = /(\w+)=((?!{)\S+|{[^}]+})/
DATE_REGEX = /((\d+-?){3}T(\d+:?){3})\.\d+/
requests = []

Dir.glob("logs/*.log") do |file|
  File.open(file).each_line do |line|
    if line.match(KEY_VALUE_REGEX)
      request = Hash[line.scan(KEY_VALUE_REGEX)]
      request[:datetime] = line.match(DATE_REGEX)
      requests << request
    end
  end
end

puts requests.to_json
