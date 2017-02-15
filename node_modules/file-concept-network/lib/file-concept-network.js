/*jshint node:true curly:true, eqeqeq:true, immed:true, latedef:true, newcap:true, noarg:true, sub:true, undef:true, eqnull:true, laxcomma:true, white:true, indent:2 */
/*
 * file-concept-network
 * https://github.com/parmentf/node-file-concept-network
 *
 * Copyright (c) 2013 François Parmentier
 * Licensed under the MIT license.
 */
"use strict";

// ## Node modules
var fs = require('fs');
var util = require('util');
var sugar = require('sugar');
var ConceptNetwork = require('concept-network').ConceptNetwork;

var FileConceptNetwork = function () {
  // Inherits ConceptNetwork
  ConceptNetwork.call(this);
};

util.inherits(FileConceptNetwork, ConceptNetwork);

FileConceptNetwork.prototype.load = function (path, cb) {
  var self = this;
  fs.readFile(path, 'utf8', function (err, data) {
    if (err) {
      cb(err, self);
      return;
    }
    var newCN = Object.create(ConceptNetwork.prototype);
    Object.merge(newCN, JSON.parse(data));
    for (var key in newCN) {
      self[key] = newCN[key];
    }
    if (cb) { cb(err, self); }
  });
};

FileConceptNetwork.prototype.save = function (path, cb) {
  fs.writeFile(path, JSON.stringify(this), 'utf8', function (err) {
    cb(err);
  });
};

module.exports = FileConceptNetwork;