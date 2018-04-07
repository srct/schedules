# Schedules

Schedules is a Ruby on Rails app that allows students to import their class schedules into popular calendar managers.

The project manager for Schedules is Zac Wood.

## Contributing

Schedules is currently being completely rewritten from scratch, so all help is much appreciated. See the current project [issues](https://git.gmu.edu/srct/schedules/issues) to see what needs to get done.  

If you need any help, please feel free to reach out in the `#schedules` channel in our [Slack group](https://srct.slack.com/). This is where most of the discussion about the project occurs, so if you are interesting in contributing, please join and say hi! 

## Setup instructions

### Install Ruby and Rails
To develop for Schedules, it is required that you have an up-to-date versions of Ruby and Rails installed. Soon, development will switch to using Docker, but for now, use [this installation guide](http://installrails.com) to get started.  

### Clone the schedules workspace
We're first going to clone down a copy of the schedules codebase from [git.gmu.edu](http://git.gmu.edu/srct/schedules),
the SRCT code respository, with SSH.

**a)** Configure your ssh keys by following the directions at:

[git.gmu.edu/help/ssh/README](http://git.gmu.edu/help/ssh/README).

**b)** Now, on your computer, navigate to the directory in which you want to download the project (ie. perhaps one called `development/SRCT`), and run

    git clone git@git.gmu.edu:srct/schedules.git

Run `cd schedules/` to enter the cloned directory, and `cd schedules/` once more to enter the Rails environment.

### Install dependencies
To install the project dependencies, run the `bundle install` command.  

### Database
To populate your local database, run `rake db:migrate:seed`. This sets up your local database and loads it with data from the Excel speadsheet(s) of GMU courses. **NOTE:** This may take a while!

### Development server
To start a local development server, run the `rails server` command. The server should now be available at `localhost:3000`.

## Opening issues

Please use the issue templates located on the new issue page when opening issues. Any issues that do not follow a template will not be accepted.

## Coding style

Please try to adhere [Airbnb's Ruby Style Guide](https://github.com/airbnb/ruby). This will not be strictly enforced, but please make sure your code is understandable and well documented.
