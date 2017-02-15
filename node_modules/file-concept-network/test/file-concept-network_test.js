/*jshint node:true curly:true, eqeqeq:true, immed:true, latedef:true, newcap:true, noarg:true, sub:true, undef:true, eqnull:true, laxcomma:true, white:true, indent:2 */
/*global describe:true, it:true, before:true */
"use strict";

// # Tests for FileConceptNetwork


// ## Required libraries
var assert = require('assert');
var ConceptNetwork = require('concept-network');
var fs = require('fs');

// ## Module to test
var FileConceptNetwork = require('../lib/file-concept-network');

// ## Let's test

describe('Load', function () {

  var fcn;

  before(function () {
    fcn = new FileConceptNetwork();
  });

  it('should work without callback', function () {
    assert.doesNotThrow(function () { fcn.load('test/cn.json'); });
  });

  it('should get the ConceptNetwork', function (done) {
    fcn.load('test/cn.json', function (err, cn) {
      assert(fcn.nodeLastId === 2);
      done(err);
    });
  });

});

describe('Save', function () {

  var fcn;

  before(function (done) {
    fs.exists('test/cn1.json', function (exists) {
      if (exists) {
        fs.unlink('test/cn1.json', function (err) {
          assert(!err);
        });
      }
    });
    fcn = new FileConceptNetwork();
    fcn.load('test/cn.json', function (err) {
      assert(!err);
      assert(fcn.nodeLastId === 2);
      done();
    });
  });

  it('should save the ConceptNetwork', function (done) {
    fcn.save('test/cn1.json', function (err) {
      if (err) { done(err); }
      fs.exists('test/cn1.json', function (exists) {
        assert(exists);
        fs.readFile('test/cn1.json', 'utf8', function (err, data) {
          assert.equal(data, JSON.stringify(fcn));
          done();
        });
      });
    });
  });

});
