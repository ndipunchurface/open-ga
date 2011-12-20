# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([
                { :name => "Activism" },
                { :name => "Education" },
                { :name => "Labor" },
                { :name => "Municipal" },
                { :name => "Non-Profit" },
                { :name => "Recreational"}])

# Development environment seeds for testing purposes
if Rails.env =~ /development/i
  facilitator = User.create( 
    :email => 'admin@example.com',
    :password => 'occupy',
    :password_confirmation => 'occupy',
    :name => 'Admin',
    :locale => 'en')

  owner = User.create(
    :email => 'owner@example.com',
    :password => 'password',
    :password_confirmation => 'password',
    :name => "Alex Owner",
    :locale => 'en')

  user = User.create(
    :email => 'user@example.com',
    :password => 'password',
    :password_confirmation => 'password',
    :name => "Sam User",
    :locale => 'en' )

  assembly = owner.assemblies.create(
    :user_id => owner.id,
    :category_id => 1,
    :name => "Test Assembly",
    :description => "Just a test assembly.",
    :city => "Philadelphia",
    :state => "PA",
    :zip => "19148" )

  user.authorize(assembly)
  facilitator.make_facilitator(assembly)

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

