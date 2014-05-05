require 'rake'
require 'yaml'
require 'digest/sha1'

desc 'Add user [name, email, pass, can write]'
task :add_user, :name, :email, :pass, :can_write do |t, args|
  config_path = File.join(__dir__, 'users.yml')
  puts "Adding user to #{config_path}"

  users = YAML::load_file(config_path)
  users ||= []
  email = args[:email]

  if users.select{ |u| u[1] == email }.size > 0
    puts 'ERROR: User exists! Exiting...'
  else
    pass = Digest::SHA1.hexdigest(args[:pass])
    users << [args[:name], email, pass, args[:can_write] == 'true']
    File.open(config_path, 'w+') { |f| f.write(users.to_yaml) }

    puts "User added. Users count = #{users.count}"
  end
end