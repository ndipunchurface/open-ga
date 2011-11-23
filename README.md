# Remote Vote
## A remote voting system

In the short term, this system is intended to be used by Occupations at their Generale Assemblies to enable remote participation. This is my solution to the dwindling numbers of ordinary middle class families, the elderly, and those with physical handicaps at the GA's. I theorize the trend of dwindling numbers will only increase as the winter months set in.
*******************************************************************************************************************
### Inteded process of user interaction

- A user goes to their local Occupation and is given a voter registration card. Voter registration does not require any personal information. The voter registration card will have a unique registration number that the user will be required to enter upon registering on the website.
- Once the user has registered they can view and "upvote" or "downvote" proposals (much like on Reddit), reply to proposals, offer amendments to the proposals, or write their own proposals. All of these types of content can be voted upon. The upvoting of a proposal *is not* a binding vote. It simply gives the Facilitators an idea of what proposals matter to the GA.
- Once the Facilitators officially bring a proposal to the GA users can discuss further and participate in a "binding vote". The binding vote is intended to be honored as a real vote at the GA. Voting would be open for 24 hours after the actual GA.
- The results of the vote will be announced at the following GA.

I feel I must emphasize that this process is entirely up to debate, and if anyone has any further thoughts on how this could work, I encourage you to contact me.
*******************************************************************************************************************
### Intended method of distribution

I wanted to combine high functionality with ease of deployment. I feel that Youtube is a good example of this. Their system works by allowing users to embed iFrames into their own site that points back to Youtube. I want to do the same here, so it doesn not take a Rails expert to deploy this, and it will be compatible with **all** platforms (Wordpress, Drupal, etc). Theoretically, using this method it could be embedded in an email, or any other unfilterd HTML based medium for that matter.

Additionally, at the suggestion of others, I have added a "Web Service" functionality. This means that people can code their own third party implementations of this application, that can then (most likely using AJAX) hit this application to interact with the database. This application would then send back a JSON response. This functionality was added to increase inclusiveness, and the number of supported platforms.
*******************************************************************************************************************
### Installation
#### What you'll need
- [Ruby on Rails](http://rubyonrails.org/download)
- [RVM](http://beginrescueend.com/)
- [SQLite](http://www.sqlite.org/)
- [MySQL](http://www.mysql.com/)
- [Git](http://git-scm.com/download) (Duh)

#### Gitting the Project

After you have all of your software installed navigate to your projects directory on your computer, or where ever you want to put your local build of Remote Vote. Run the following in your command line to grab a copy of the source code:

	$ git clone http://github.com/jonlaing/Remote-Vote.git

#### Installing the Bundler

Then navigate to your fresh download in the command line by running:

	$ cd Remote-Vote

Upon doing this you should be prompted that a .rvmrc file has been detected. You will be prompted to accept the file. Accept the file and a new gemset will be created for you in RVM. This new gemset is completely empty so you're going to need to download the Bundler to install all of the dependencies. Run the following code in the Remote-Vote directory:

	$ gem install bundler

#### Installing dependencies

After you've downloaded the bundler, you will need to install the project's dependencies. You can do this by running the following:

	$ bundle install

#### Configuring your project

There are currently three configuration files that you will need to make the application run. You can get them by running the following:

	$ cp config/application.example.yml config/application.yml
	$ cp config/database.example.yml config.database.yml
	$ cp config/devise.example.yml config/devise.yml

You can then edit the files in your IDE or text editor of choice. You don't _need_ to edit them though; they will work just fine on your local machine with their default settings. However, if you do push to production, you will need to repeat the process and edit the files to match your server's specifications.

#### Building the database

To build your database and the necessary tables, run:

	$ rake db:migrate

#### Running the application

To run your application locally, run:

	$ rails server

And then navigate to http://localhost:3000/
*******************************************************************************************************************

### Credits

- **Jon Laing** - Lead programmer and software architect
- _Anyone who wants to help! Please contact me if you want to be a part of this project!_

*******************************************************************************************************************
Currently this software *is not* an official endeavor. I wanted to build the software *and then* present it to the Occupy Philadelphia (my local Occupation) GA and have their thoughts. I also would need to do some user testing to make sure the process actually works.
