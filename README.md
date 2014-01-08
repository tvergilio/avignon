avignon
=======

To start the application: padrino start

For viewing all companies:
==========================
http://localhost:3000/companies

For viewing a company:
=======================
http://localhost:3000/companies/show/1
(where 1 is the company_id)

TODO: show a list of directors associated with the company

For viewing a director:
=======================
http://localhost:3000/directors/show/1
(where 1 is the director_id)

TODO: show a link to the company the director is associated with

File upload page:
=================
http://localhost:3000/directors/attach

TODO: attach it to a single director using the director_id

currently getting: Forbidden - attack prevented by Rack::Protection::AuthenticityToken POST /webservice/companies Forbidden

Test POST request using cURL:
=============================
curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d  "{\"company\":{\"name\":\"Melancia\",\"address\":\"26 Blenkinsop Way\",\"city\":\"Leeds\",\"country\":\"UK\",\"email\":\"melancia@fruta.co.uk\",\"phone\":\"07734699224\"}}" http://localhost:3000/webservice/companies/

currently getting: Forbidden - attack prevented by Rack::Protection::AuthenticityToken POST /upload Method Not Allowed

TODO: switch off authentication for POST requests (not recommended, for debugging only!) or find a different way to send the requests (not using cURL).

TODO
====
Implement and test remaining HTTP methods on webservice.rb

Stop POST from creating duplicate records

