To develop on RAMS Core:
===

1. Clone the quickstart repo.
2. `git clone https://github.com/RAMSProject/rams.git src/uber`
3. Clone any other plugins you are using into src/
4. `docker-compose -d up`
5. Access via your local path output of `docker-machine ip dev`) [TODO: elaborate]
6. Edit the code in src/ - most updates should be live. Use `docker-compose` to restart daemon if needed.

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
===

To insert an admin user, visit the following URL: <docker machine ip>/uber/accounts/insert_test_admin

Now you can login to the web app with username "magfest@example.com" and password "magfest"
