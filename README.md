# Schedules

Schedules is a web app that is written with Ruby on Rails and allows students build, share, and export their Schedules. It includes a powerful search engine which lets students get information about both courses and professors at GMU.

The project manager for Schedules is Zac Wood.

## Contributing

Schedules is currently in version 2 and is a somewhat mature web application. However, there are always new features that can be added and old bugs that need fixing, so all help is much appreciated. See the current project [issues](https://git.gmu.edu/srct/schedules/issues) to see what needs to get done, or submit an issue of your own if you have a feature request or found a bug.  

If you need any help, please feel free to reach out in the `#schedules` channel in our [Slack group](https://srct.slack.com/). This is where most of the discussion about the project occurs, so if you are interesting in contributing, please join and say hi! 

### Learning Ruby on Rails

Rails is a web framework written in Ruby that makes developing web applications fun and productive. However, it does have quite a steep learning curve. Before you contribute to Schedules, it's worth learning the basics of Rails first. This will give you the ability to understand and navigate through the project structure before trying to make your contribution.  
Thankfully, there are tons of great free online resources to learn Rails. Here are a few that we recommend to newcomers:  
- [Derek Banas' Ruby on Rails Tutorial (30min)](https://www.youtube.com/watch?v=GY7Ps8fqGdc)
- [Rails Tutorial (free online ebook)](https://www.railstutorial.org/book)
- [Official Getting Started with Rails](https://guides.rubyonrails.org/getting_started.html)

### Modifying and Deploying Code

Please read through the CONTRIBUTING.md document for in depth
instructions on the process of making and submitting changes to
Schedules.

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

Run `cd schedules/` to enter the cloned directory.

## Setting up Project

Execute `cd schedules/` to enter the Project directory.

### Install dependencies
To install the project dependencies, run the `bundle install` command.  

### Database
To populate your local database, run `rails db:migrate` and `rails db:seed`. This sets up your local database and loads it with data from Patriot Web. 
**NOTE:** Sometimes Patriot Web doesn't appriciate being parsed. If you're having problems,
please let us know in [Slack](https://srct.slack.com/)!


## Development servers

While developing for schedules, it is useful to have development servers running.

To start the Project, run the `rails server` command in the `/schedules` directory. The website should now be accessible from `localhost:3000`
