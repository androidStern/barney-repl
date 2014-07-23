through = require 'through2'

coffee_repl = require 'coffee-script/lib/coffee-script/repl'

util = require 'util'

EE = require('events').EventEmitter

NOOP = ->

Repl = ->
    self = this
    EE.call(this)

    input = new through()
    output = new through()

    ###*
     * Proxy the repl's output.
    ###
    output.on "data", (d)-> self.emit("output", d.toString())

    r = coffee_repl.start({output: output, input: input, prompt: ""})

    ###*
     * Because there isnt a cursor or prompt. Keeps the repl code from throwing
     * errors
    ###
    r.displayPrompt = NOOP
    r.rli.output.cursorTo = NOOP
    r.rli.output.clearLine = NOOP
    r.rli.output.displayPrompt = NOOP

    toggleMultiLine = ->
        r.inputStream.emit("keypress", null, {name: 'v', ctrl: true})

    ###*
     * Step 1: enter multiline mode
     * Step 2: run your code
     * Step 3: exit multiline -- which triggers the actual eval
    ###
    self.run = (code)->
        toggleMultiLine()
        r.rli.emit("line", code)
        toggleMultiLine()
        return self

    return self

util.inherits Repl, EE

module.exports.Repl = Repl
