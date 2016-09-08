# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Site.create(:name => 'Prontotools', :domain => 'http://prontotools.pi.bypronto.com/', :port => '9118', :database_name => "prontotools_database")
Site.create(:name => 'Master Computing', :domain => 'https://www.master-computing.com', :port => '9111', :database_name => "master computing")
Site.create(:name => 'KamNamChul', :domain => 'https://www.kamnanchul.com/', :port => '4000', :database_name => "kamnanchul computing")
