express = require 'express'
consolidate = require 'consolidate'

# Helper: create a route from a route name (e.g., /simple -> /routes/simple.coffee)
createRoute = (routeName) ->
    route = require('./routes/' + if routeName == '/' then 'index' else routeName[1..] + '.coffee').route
    app.get routeName, route

#
# Set up Express with Handlebars as the templating engine (via Consolidate).
#
app = express()
app.engine 'html', consolidate.handlebars
app.set 'view engine', 'html'
app.set 'views', __dirname + '/views'
app.use express.static('views')

# The index file just contains links to the examples.
createRoute '/'

# Simple static data substitution example.
createRoute '/simple'

# App.net global timeline example.
createRoute '/posts'

# App.net global timeline example (with profiling).
createRoute '/profile'

app.listen 3000

console.log '\nVisit http://localhost:3000 to view the Handlebars examples…\n'