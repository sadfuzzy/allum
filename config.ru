__dir__ = File.expand_path(File.dirname(__FILE__))
$: << __dir__
require 'rubygems'
require 'yaml'
require 'app'

App.set(:gollum_path, __dir__ + "/wikidata")
App.set(:authorized_users, YAML.load_file(File.expand_path('users.yml', __dir__)))
App.set(:default_markup, :markdown)
App.set(:wiki_options, {universal_toc: false})
run App
