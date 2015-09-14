ramsproject/sideboard: This is the Sideboard base container. You probably don't need to touch this; if you do, just rebuild it manually using the Dockerfile in that repo.

ramsproject/rams: This is the RAMS core container. It's built automatically on every docker-compose up, incorporating any changes that have been made to core. If you need to rebuild it manually, use the Dockerfile in this repo.

ramsproject/rams-event: This is an example Event Specific Plugin. It's also built automatically via docker-compose up; be sure that its Dockerfile is pointing at the appropriate version of rams-core. When developing in this branch, if you make a change to core, you'll need to rebuild your locally tagged version of rams-core and then do your docker-compose up here.
