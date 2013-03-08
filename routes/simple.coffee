# Same data as the plates example
data =
    title: 'Express 3‐Handlebars sample'
    name: 'Express 3‐Handlebars'
    content: 'This is a simple example to demonstrate Express 3‐Handlebars'
    newURL: 'http://aralbalkan.com'
    correctURLFragment: 'moderniosdevelopment'
    aralImageURL: 'http://aralbalkan.com/images/aral.jpg'
    friends:
        [
            {name: 'Laura', skills: 'design, development, illustration, speaking'},
            {name: 'Seb', skills: 'particles, games, JavaScript, C++'},
            {name: 'Natalie', skills: 'HTML, CSS'}
        ]

exports.route = (request, response) ->
	response.render 'simple', data