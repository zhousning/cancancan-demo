# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#the highest role with all the permissions.

Role.create!(:name => "Super Admin")
Role.create!(:name => "Staff")

Permission.create!(:subject_class => "all", :action => "manage")

role = Role.find_by_name('Super Admin')
role.permissions << Permission.where(:subject_class => 'all', :action => "manage")

user = User.new(:name => "admin", :email => "admin@qq.com", :password => "admin@qq.com", :password_confirmation => "admin@qq.com")
user.role = role
user.save!
 
User.create(:name => "zhouning", :email => "zhouning@qq.com", :password => "zhouning@qq.com", :password_confirmation => "zhouning@qq.com", :role_id => Role.find_by_name('Staff').id)
