avignon
=======

Deployed to Heroku. The whole user interface will be replaced by the monaco project (https://github.com/tvergilio/monaco).
Avignon will be simply a RESTful webservice.

GET (for getting all companies):
==========================
http://ancient-beach-1323.herokuapp.com/webservice/companies

GET (for getting a single company):
=======================
http://ancient-beach-1323.herokuapp.com/webservice/companies/1
(where 1 is the company_id)

TODO
====
Implement and test remaining HTTP methods on webservice.rb

Request them using the monaco app (AngularJS project)


File upload page (will change):
=================
http://ancient-beach-1323.herokuapp.com/directors/attach

TODO: attach it to a single director using the director_id

currently getting: Forbidden - attack prevented by Rack::Protection::AuthenticityToken POST /webservice/companies Forbidden

Test POST request using cURL:
=============================
$ curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d "{\"company\":{\"name\":\"Melancia\",\"address\":\"26 Blenkinsop Way\",\"city\":\"Leeds\",\"country\":\"UK\",\"email\":\"melancia@fruta.co.uk\",\"phone\":\"07734699224\"}}" http://ancient-beach-1323.herokuapp.com/webservice/companies/

still getting: Forbidden - attack prevented by Rack::Protection::AuthenticityToken POST /upload Method Not Allowed

TODO: switch off authentication for POST requests (not recommended, for debugging only!) or find a different way to send the requests (not using cURL).

THIS IS PROVISIONAL! POST requests will be sent through monaco app created using AngularJS (work in progress).

