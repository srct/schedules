# Schedules

Schedules is a web app that allows students to import their class schedules into popular calendar managers. It consists of an API written in Ruby on Rails and a web client built with React.

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

Run `cd schedules/` to enter the cloned directory

## Setting up API

Execute `cd schedules_api/` to enter the API directory.

### Install dependencies
To install the project dependencies, run the `bundle install` command.  

### Database
To populate your local database, run `rake db:migrate:seed`. This sets up your local database and loads it with data from the Excel speadsheet(s) of GMU courses. **NOTE:** This may take a while!

## Setting up client

### Install dependencies

To install the React client's dependencies, run the `yarn` command from the `/schedules_web` directory.

## Development servers

While developing for schedules, it is useful to have development servers for both the React client and the Ruby on Rails API running.

### API
To start the API, run the `rails server` command in the `/schedules_api` directory. The API should now be accessible from `localhost:3000`

### Client
To start the development server for the React client, run the `yarn start` command from the `/schedules_web` directory. The client should now be available from `localhost:8080`.

## Testing
Before you make a commit, you should ensure you new code passes the project's tests. 

It is recommended that you write tests for any new code you add, but this is not required.  

### API
To run the API's tests, run the command `rails test` from the `schedules_api` directory.

### Client
To run the client's test, run the `yarn test` command from the `schedules_web` directory.

## Opening issues

Please use the issue templates located on the new issue page when opening issues. Any issues that do not follow a template will not be accepted.

## Coding style

The style for this project is the [Relaxed Ruby Style](http://relaxed.ruby.style), which is a subset of the community-driven [Ruby style guide](https://github.com/bbatsov/ruby-style-guide) with more relaxed rules.  

A great tool for making sure your code meets the project's style is [RuboCop](https://github.com/bbatsov/rubocop). To use RuboCop, install it by running the command  
    
    gem install rubocop
    
Then, when inside the `/schedules_api/` directory, you can run the command `rubocop` to see where your style does not match the project's.
