# 0.0.5 2015-03-11

## Features

Replaced deasync with async as a dependency for synchronizing functions which require multiple API calls. This should help compatibility with applications such as Hubot which do not work well with deasync.

# 0.0.4 2015-03-10

Minor documentation updates

# 0.0.3 2015-03-10

## Features

Added ```Tousen#get_events_silence_status```, which returns a list of all events with parameters indicating whether a silence stash exists for the client or the check for which the event applies.

# 0.0.2 2015-03-10

## Features

Sensu API methods complete for the following endpoints:

- Aggregates
- Checks
- Clients
- Events
- Info
- Stashes

## Other

First working release.
