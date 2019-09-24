# frozen_string_literal: true

require 'open3'
require './rakelib/support/shell_command'

# see: https://danger.systems/ruby/
desc 'run danger-ruby'
task :danger do
  require 'rainbow'

  puts 'running danger...'
  danger_result = ShellCommand.run("danger")
  puts "\n"

  puts "\n"
  if danger_result
    puts Rainbow('Danger ran successfully.').green
  else
    puts Rainbow('Failed. Something went wrong while running danger-ruby').red
    exit!(1)
  end

end
