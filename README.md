# What is barney-repl?

*barney-repl* is a tiny evented wrapper around coffee-script's repl.
It just takes a string of coffee-script code and pipes it into a running repl,
emitting the resulting output to any listeners you've attached.

## Installation

```
$ npm i barney-repl
```

## Example

```
{Repl} = require 'barney-repl'

repl = new Repl()

repl.on "output", console.log

repl.run("10") #=> logs: 10

repl.run("x = 100") #=> logs: 100

repl.run("x + 1") #=> 101 ...same repl & same context across multiple calls
```

# What is it good for?

It handles multi-line strings. Meaning this will work just fine:
```
{Repl} = require 'barney-repl'

repl = new Repl()

repl.run("""
    x = 20
    y = x + 1
    """)
```

# What is it bad at?
*Stopping*. No seriously, I have no idea how to make the thing stop so don't use it
if you don't want it running for the lifetime of your application.

# It doesn't seem like production ready software...?
No it doesn't.

# API


### .run
Run some code.
```
repl.run(some_coffee_script_code_string)
```

### .on

Attach a callback to be called with any new output.

```
repl.on "output", (output)->
```

Thats it...

## Roadmap

* Distinguish between normal output and errors.
* STOP THIS CRAZY CAVE MAN
* Add restart/clear/quit
