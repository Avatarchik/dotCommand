EventEmitter = require('events').EventEmitter
spawn = require('child_process').spawn


class nugetRestore

    emitter = new EventEmitter

    constructor: (@slnPath, @nugetConfig) ->

    restore: ->
        args = ['restore', @slnPath]

        opts = { stdio: 'inherit' }

        # Using spawn as it allows us to retain the coloured output from nunit.
        # I couldn't get execfile doesn't retain colour info
        exec = spawn 'nuget', args, opts

        exec.on 'close', (code) ->

            if code == 0
                emitter.emit 'success'
            else
                emitter.emit 'error'

            emitter.emit 'done'

    on: (name, cb) ->
        emitter.on name, cb

module.exports = nugetRestore