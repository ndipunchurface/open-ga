# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env =~ /development/i
  admin = User.create( 
    :email => 'admin@example.com',
    :password => 'occupy',
    :password_confirmation => 'occupy',
    :name => 'Admin',
    :locale => 'en',
    :is_admin => true )

  owner = User.create(
    :email => 'owner@example.com',
    :password => 'password',
    :password_confirmation => 'password',
    :name => "Alex Owner",
    :locale => 'en',
    :is_admin => false )

  user = User.create(
    :email => 'user@example.com',
    :password => 'password',
    :password_confirmation => 'password',
    :name => "Sam User",
    :locale => 'en',
    :is_admin => false )

  assembly = Assembly.create(
    :user_id => owner.id,
    :name => "Test Assembly",
    :description => "Just a test assembly.",
    :city => "Philadelphia",
    :state => "PA",
    :zip => "19148" )

  user.authorize(assembly)
  admin.authorize(assembly)

  proposal = assembly.proposals.create(
    :user_id => user.id,
    :title => "Test Proposal",
    :body => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum placerat pulvinar tempor. Quisque dictum placerat elementum orci aliquam. #testtag" )

  amendment = proposal.amendments.create(
    :user_id => owner.id,
    :title => "Test Amendment",
    :body => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum placerat pulvinar tempor. Quisque dictum placerat elementum orci aliquam..." )

  reply1 = proposal.replies.create(
    :user_id => owner.id,
    :body => "Just a test reply." )

  reply2 = amendment.replies.create(
    :user_id => user.id,
    :body => "Another test reply." )
end
