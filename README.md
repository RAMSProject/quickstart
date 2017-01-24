# Getting Started Developing in RAMS: Community Edition

## Getting to Know RAMS: What We Use
 If you just want to spin up an instance, feel free to skip down to "Before You Start: Setting Up Your Environment." However, if you're brand new, you should familiarize yourself with our structure.

### RAMS Technology

RAMS is a plugin for [**Sideboard**](https://github.com/magfest/sideboard), a custom framework that ties plugins together and runs them as a web app. The "uber" plugin - [which is its own repo](https://github.com/RAMSProject/rams) - is most of what you'll be working with. In general you shouldn't need to worry about Sideboard, but be aware that it has several overrides for built-in Python libraries. It will be automatically included when you install RAMS following the instructions below.

 RAMS follows a MVC structure, with **CherryPy** tying the view and controller together. Every template (in `/uber/templates/`, excluding the `static_views` folder) requires a function of the same name in `/uber/site_sections`.

 The entire model is declared in `/uber/models.py` using the **SQLAlchemy** ORM. We use **PostgreSQL** for our database, and **Alembic** to create and run database migrations.

 Currently, all configuration for the app is defined in four files:
 * `/uber/configspec.ini` declares the static variables and includes in-line explanations of each.
 * `/development-defaults.ini` sets up sane defaults for an example event.
 * `/development.ini`, which is not checked into Git, can be used to override any config option in your local environment.
 * `/uber/config.py` processes these variables and inserts them into a global `c` object. Config.py also defines dynamic variables and properties, which are also added to the `c` object.
 
### RAMS Structure
If you use this repo, your folder structure may not look exactly like this. For example, Sideboard is its own Docker container, so you will not see it. However, it is useful to know what the actual file structure would be if you installed RAMS 'bare' on your machine by cloning the Sideboard repository, then cloning the RAMS repository and other RAMS plugins into Sideboard's plugins folder (see below).

Assuming you had created a folder to contain RAMS called `RAMS Test`, your folder structure might look like this:
* RAMS Test
 * *various Sideboard folders*
 * `development.ini`: called sideboard-development.ini in Quickstart, this is a config file for Sideboard. You might use this to control the order in which plugins are loaded.
 * `plugins`: this will show as `quickstart/src` when using this repo.
   * `uber`: this will contain the `rams` repository. Due to legacy naming conventions, it must be named `uber`.
     * `development.ini`: called development.ini in Quickstart, this is the config file for RAMS. See RAMS Technology, above, for how this interacts with two other config files.
     * `uber`: this contains the bulk of the RAMS app. Most code changes would be in this folder.
       * `site_sections`
       * `templates`
       * `tests`
       * `static`
       * *.py files not associated with specific webpages, e.g., models.py, config.py*
   * `your_custom_plugin`
     * `development.ini`: each custom plugin can have its own set of config.
     * `your_custom_plugin`: the contents of this subfolder should strongly mirror that of the RAMS plugin itself to enable overrides. Sideboard does in-place replacements of files in the same place with the same name.

## Quickstart Instructions
### Before You Start: Setting Up Your Environment
1. If you are not familiar with using the command-line, we recommend you install a Git management tool. Windows and Mac users can try [GitHub for Desktop](https://desktop.github.com/). For a full IDE with a Git management tool, we recommend [PyCharm](https://www.jetbrains.com/pycharm/), which works on Windows, Mac, and Linux.
2. Install [Docker](https://docs.docker.com/installation/#installation).
 * Linux users should install [Docker Machine](https://docs.docker.com/machine/install-machine/) separately. For Mac and Windows, it will be included with Docker Toolbox.
3. Install [Docker Compose](https://docs.docker.com/compose/install/). For Windows, you will need to use these [unofficial installation instructions.](http://stackoverflow.com/questions/29289785/how-to-install-docker-compose-on-windows)

### Spinning Up a Development Environment
1. Browse to the directory you want to put your folder structure in.
2. Using your preferred tool, clone the quickstart repo into that directory. The DOS/bash command for this is `git clone https://github.com/ramsproject/quickstart`.
3. Windows: Open up a DOS prompt in administrator mode. Mac/Linux: Open up a bash prompt.
4. `cd` into the `quickstart` directory.
5. Run `git clone https://github.com/RAMSProject/rams.git src/uber`.
6. Clone any other plugins you are using into src/
7. (Linux only?) Run `sudo service docker start`.
8. Run `sudo docker-compose up -d` [TODO: Windows instructions] *Note*: The -d flag runs this process in the background.
9. Browse to http://localhost/rams 
10. Edit the code in src/ using your preferred tool - static files (like HTML) will be updated on-the-fly. Run `sudo docker-compose restart web` to propagate other changes.

## Developing in Docker
### Explanation and Common Commands
Docker spins up three containers: `db` for the postgres database, `redis` for the config database, and `web` for the application itself. In general, we recommend you do not touch the insides of these containers with `docker exec`-like commands. Managing them through docker-compose will ensure that your results are reproducible for others.

The basic structure of docker-compose commands is `sudo docker-compose COMMAND CONTAINER`. If no container is specified, it will run the command against all active containers.

**To create a test admin account**, curl (or browse to) http://localhost/rams/accounts/insert_test_admin. The test account's name is `magfest@example.com` and its password is `magfest`

**To restart the server**, run: `sudo docker-compose restart web`.

**To reset the database**, run:
```bash
# NOTE: Doing this will remove all data from both databases! Use caution, please!
sudo docker-compose stop
sudo docker-compose rm # You will need to confirm this
sudo docker-compose up -d
```

**To check if your server is still running**, run: `sudo docker-compose ps`

**To inspect the logs** (e.g., to see why the web server crashed), run: `sudo docker-compose logs web`

**To start all stopped services** (e.g., after restarting your dev box), run: `sudo docker-compose start`

If you need to build/change Python or Javascript dependencies you'll have to change `requirements.txt` or `bower.json` and manually rebuild the ramsproject/rams container locally using `sudo docker-compose build web`. Ditto if you're changing something in Sideboard itself. Note: if you don't know if you're doing either of these, you probably aren't.

In rare cases, your containers may not pull all their files properly or may become corrupted. **To completely kill your containers and re-pull them**, run:
```bash
sudo docker stop
sudo docker rm
sudo docker rmi ramsproject/rams # You may need to use the -f flag here
sudo docker-compose up -d
```

### Pushing to a Remote Server
*Note*: This feature is meant mostly for development. Use it in production with caution.

Once you are ready to deploy your work to a remote server:

1. It is _strongly recommended_ that you commit your current changes to Git before pushing to a remote server.
2. Open a new window (or tab) for DOS or bash.
3. Refer to the Docker Machine [list of supported servers](https://docs.docker.com/machine/drivers/) to find which command you need. We'll be assuming you use DigitalOcean.
4. Run the following commands:

```bash
# Substitute your personal token for the access token and rename "MY-SERVER" anything you want. Don't use underscores, though.
# If you don't use Digital Ocean, please refer to the Docker Machine page for the right create command for you.
docker-machine create --driver digitalocean --digitalocean-access-token=YOUR_TOKEN_HERE MY-SERVER

# Tell docker-compose to talk to our server instead of our local machine.
eval "$(docker-machine env MY-SERVER)"

# The next step uploads your entire src directory to the remote server. It may take some time.
docker-compose -f docker-staging.yml up -d
```

After those commands have finished, you will be able to interact with your server almost exactly like you interact with your development environment - the only difference is that you do not need `sudo` access to run docker-compose commands on your server.

To re-deploy a new version of the code to your remote server, run:
```bash
docker-compose build web
docker-compose stop web
docker-compose rm web
docker-compose -f docker-staging.yml up -d
```
