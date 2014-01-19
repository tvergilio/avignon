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

GET (for getting a single director):
==========================
http://ancient-beach-1323.herokuapp.com/webservice/directors/1
(where 1 is the director_id)

POST (for creating a single company):
=======================
http://ancient-beach-1323.herokuapp.com/webservice/companies/

PUT (for updating a single company):
=======================
http://ancient-beach-1323.herokuapp.com/webservice/companies/1
(where 1 is the company_id)

DELETE (for deleting a single company):
=======================
http://ancient-beach-1323.herokuapp.com/webservice/companies/1
(where 1 is the company_id)

TODO
====
Request the POST, PUT and DELETE methods using the monaco app (AngularJS project)


File upload page (will change):
=================
http://ancient-beach-1323.herokuapp.com/directors/attach

TODO: attach it to a single director using the director_id

currently getting: Forbidden - attack prevented by Rack::Protection::AuthenticityToken POST /webservice/companies Forbidden

Test POST request using cURL:
=============================
$ curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d "{\"company\":{\"name\":\"Melancia\",\"address\":\"26 Blenkinsop Way\",\"city\":\"Leeds\",\"country\":\"UK\",\"email\":\"melancia@fruta.co.uk\",\"phone\":\"07734699224\"}}" http://ancient-beach-1323.herokuapp.com/webservice/companies/

TODO: find a better way to protect against csrf. Currently switched it off to prevent "Forbidden - attack prevented by Rack::Protection::AuthenticityToken POST /upload Method Not Allowed". There must be a better way!


