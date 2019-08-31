Pry.history.instance_eval do
   @saver = ->(line) { save_to_file (line.force_encoding(STDIN.external_encoding))}
end

Pry.config.history.file = File.expand_path('~/.config/pry/history')

# vim: set filetype=ruby:
