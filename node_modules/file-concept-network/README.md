# file-concept-network [![Build Status](https://secure.travis-ci.org/parmentf/node-file-concept-network.png)](http://travis-ci.org/parmentf/node-file-concept-network) [![NPM version](https://badge.fury.io/js/file-concept-network.png)](http://badge.fury.io/js/file-concept-network)

Concept Network is weighted directed graph, in which activation values are propagated. Written in [Node.js](http://nodejs.org).

File Concept Network is the version with file system persistence.

## Getting Started
Install the module with: `npm install file-concept-network`

```javascript
var FileConceptNetwork = require('file-concept-network').FileConceptNetwork;
var fcn = new FileConceptNetwork();
var node1 = fcn.addNode("ECTOR");
var node2 = fcn.addNode("knows");
var node3 = fcn.addNode("Achille");
fcn.addLink(node1.id, node2.id);
fcn.addLink(node2.id, node3.id);
fcn.save('cn.json', function (err) {
  if (err) {
    console.error(err);
  }
});
```

## Documentation
_(Coming soon)_

## Examples
_(Coming soon)_

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint, and test your code using [mocha](http://visionmedia.github.com/mocha/).

## Release History
* 2014/08/07: version 0.1.2: treat error cases
* 2013/01/25: version 0.1.1: fix npm module
* 2013/01/19: version 0.1.0

## License
Copyright (c) 2013 François Parmentier
Licensed under the MIT license.
