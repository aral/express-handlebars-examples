handlebars = require 'handlebars'
superagent = require 'superagent'

exports.route = (request, response) ->
    # Time the data call

    superagent.get('https://alpha-api.app.net/stream/0/posts/stream/global')

        .end (error, globalTimelineResponse) ->

            globalTimeline = globalTimelineResponse.body

            # Provide a helper so we can inject the HTML of posts from App.net into the template.
            # PS. I’ve added the ability to register helpers for Handlebars into
            # === consolidate. This won’t work on a vanilla install from npm until it
            #     gets pulled in to a release.
            #
            # See https://github.com/aral/consolidate.js/commit/979ee82c85e0880fd5a49bff9f5c2929b395257e
            #
            globalTimeline.helpers = {
                safe: (object) ->
                    return new handlebars.SafeString(object);
            }

            # Handle network and App.net errors gracefully.
            if error
                # There was a network error
                globalTimeline.errorType = 'Network'
                globalTimeline.error = error

            else if not globalTimeline.data

                # There was an App.net error
                globalTimeline.errorType = 'App.net'
                globalTimeline.error = "(##{globalTimeline.meta.code}) #{globalTimeline.meta.error_message}"

            # Time the template render
            response.render 'posts', globalTimelineResponse.body
