require 'simplecov'

SimpleCov.start do
  add_filter "/app/admin"
  add_filter "/features"
end
