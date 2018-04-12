# PatriotWeb Parser

Known working as of 2:46PM April 12th. 

### Usage
Just: `gem install bundler`, `bundle install` and `ruby parse_patriot_web.rb`

Requires nokogiri which may require actual packages as it's a native extension.

## Holding Pattern

Presently for this script we are in a holding pattern since they plan on changing the PatriotWeb backend to CAS April 15th. Should they choose to change the endpoints we hit to authenticated, we're pretty screwed, so there's no reason to flesh out a full service before then.

## Future Plans

In the future, this should write to a persistent region like JSON or MySQL to be the backend of an API for Schedules and any other services.

### Enhancements to Make Soon:

- Strip multiple (regex?) spaces from teacher names
- Rubocop complaint
- Make it write to an actual persistent database storage engine
