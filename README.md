# tousen

tousen (豆扇) is an async Sensu API client written in CoffeeScript, originally developed for use with [Hubot](https://hubot.github.com/)

See *Generating Documentation* for information on how to generate the documentation which describes the various API methods tousen provides.

Full documentation of all API wrapper methods can be found on the appropriate classes [here](http://contegix.github.io/tousen/doc/index.html).

Presently, it is in the very early stages of development.

## Installation

```
npm install tousen
```

### Dependencies

- scoped-http-client

## Usage

Require the package and instantiate a client.

```
Tousen = require 'tousen'
sensu_api = new Tousen 'http://sensu.example.com'
```

Then, make some API calls!

```
sensu_api.events.get_events callback: (err, res) ->
  if err
    console.log 'It looks like the Sensu API may not be working :('
  else
    console.log 'res is now an object containing all events!'
```

Full documentation may be found [here](http://contegix.github.io/tousen/doc/index.html).
 
## Generating Documentation

Documentation may be generated using [codo](https://github.com/coffeedoc/codo). To do so:

```
npm install
codo
```

Then, open ```doc/index.html``` in a browser to view it.

## Acknowledgements

Credit goes to [@foonix](https://github.com/foonix) for the name of this project.
