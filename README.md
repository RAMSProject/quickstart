To develop on RAMS Core:
1. Clone the quickstart repo.
2. Clone all plugins into src/ - at a minimum you must clone ramsproject/rams into src/uber/
2. `docker-compose -d up`
3. Access via your local path (localhost or output of boot2docker ip) [TODO: elaborate]
4. Edit the code in src/

If you need to build/change Python or Javascript dependencies you'll have to change `requirements.txt` or `bower.json` and manually rebuild the ramsproject/rams container locally. Ditto if you're changing something in Sideboard itself. Note: if you don't know if you're doing either of these, you probably aren't.


To get a basic copy of RAMS up and running:
===
```
docker-compose up -d
```
Then browse to http://localhost:8282/uber - if you're using boot2docker you may need to use the IP address from `boot2docker ip` instead of localhost.


Whoa, back up a bit! How do I get this Docker thing running?
===
Docker has very comprehensive install docs: https://docs.docker.com/installation/#installation
You may also need to install docker-compose separately.

https://registry.hub.docker.com/u/dduportal/docker-compose/
http://stackoverflow.com/questions/29289785/how-to-install-docker-compose-on-windows

`brew install docker-compose`
'pip install docker-compose'

--------------

Next steps!

To insert an admin user, visit the following URL: <docker machine ip>/uber/accounts/insert_test_admin

Now you can login to the web app with username "magfest@example.com" and password "magfest"
