fs = require 'fs'
yaml = require 'js-yaml'

module.exports = (env, callback) ->

  class YAMLPlugin extends env.ContentPlugin

    constructor: (@filepath, @text, @data) ->


    getFilename: ->
      @filepath.relative

    getView: -> (env, locals, contents, templates, callback) ->
      callback null, new Buffer(@text)

  YAMLPlugin.fromFile = (filepath, callback) ->
    fs.readFile filepath.full, (error, result) ->
      if not error?
        data = yaml.load result.toString()
        plugin = new YAMLPlugin filepath, result.toString(), data
      callback error, plugin

  env.registerContentPlugin 'yaml', '**/*.*(yaml|yml)', YAMLPlugin

  callback()
