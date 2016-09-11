Docker Rainloop
=============

Rainloop web client Docker image using nginx.

	docker run -d --name rainloop -h rainloop -p 8080:80 suixo/rainloop

Open your browser and visit

	http://127.0.0.1:8080

Admin panel

	http://127.0.0.1:8080/?admin
    login: admin
    password: 12345

Change it as soon as you can.

Data is stored in /webapps/rainloop/data, to externalize it, use -v option and sync data inside container OR you can run a first "dummy" container, copy data localy, destroy it, and re-run with -v.

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
