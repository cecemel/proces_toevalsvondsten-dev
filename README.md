# proces_toevalsvondsten-dev

## deployment of dev environment for the 'proces_toevalsvondsten' app

### build instructions

#### assumes
- access to OE private repos
- osx/linux environment
- docker installed
- python installed
- git
- your wildcards-private.ini files
- pycharm enterprise edition

#### general setup
```
# assumes you have access to OE private repos
git clone --recursive https://github.com/cecemel/proces_toevalsvondsten-dev.git
cd proces_toevalsvondsten-dev
# now, you have to add the development-private.ini and wildcards files on the right place,
ask your colleagues for help if you don't know
```

The following config files are required:
- vondstmeldingen/development-private.ini
- storageprovider/development-private.ini
- proces_toevalsvondsten/proces/development-private.ini
- proces_toevalsvondsten/daemon/scripts_local/local_daemon_config.ini
- dossierdata/dossierdata/development-private.ini

#### building the frontend
```
TODO (for an automated build):-/
```
You will probably want to interact with proces_toevalsvondsten and vondstmeldingen UI:
```
# assumes in proces_toevalsvondsten/proces/proces_toevalsvondsten/static/admin
npm install; bower install

# assumes in /proces_toevalsvondsten-dev/vondstmeldingen/vondstmeldingen/static
npm install; bower install
```

### building, migrating & init elastic, dummy data etc...
```
# assumes you are in folder proces_toevalsvondsten-dev
docker-compose stop; docker-compose rm -f; #not required, but cleans your working environment
# assumes you are in proces_toevalsvondsten-dev
python build_images.py [GITHUB_USER] [GITHUB_PASS];
python migrate_dbs.py;
python init_data.py [GITHUB_USER] [GITHUB_PASS];
```

#### reset backend one liner
```
docker-compose stop; docker-compose rm -f; rm -rf data/*; python build_images.py [GITHUB_USER] [GITHUB_PASS]; python migrate_dbs.py; python init_data.py [GITHUB_USER] [GITHUB_PASS];
```

### running in pycharm
see e.g.
https://blog.jetbrains.com/pycharm/2017/03/docker-compose-getting-flask-up-and-running/

### rebuilding and running a dependent service
```
# e.g.
python build_images.py [GITHUB_USER] [GITHUB_PASS] storageprovider
```
Note: rebuilding proces_toevalsvondsten/proces will only work by calling:
```
python build_images.py [GITHUB_USER] [GITHUB_PASS] proces_toevalsvondsten
```
TODO: needs fix

### some git submodule tricks
- tutorial: https://git-scm.com/book/en/v2/Git-Tools-Submodules
- some good submodule SO: https://stackoverflow.com/questions/1030169/easy-way-to-pull-latest-of-all-git-submodules
- bringing *-dev repo up to data: git pull; git submodule update --init --recursive

### caveats-todos!
- Adding a vondstmelding: please make sure e.g. the contour is located in dentergem
- on slow networks, you'll might have to build a couple of times (2,3) again, because some scripts are not robust. needs fix
- docs need to be build automatically
- scripts contain some hard coded parameters and should be cleaned
- currently, if you change code or config in dependent services, you will have to build and run every time again
- if you add a new dependent service and it needs a database, you will have to remove the postgres folder, and start the build from scratch
- working with private pypi server is still a hack, needs a fix
- a generic base image should be extract to speed up image build
- clean-up scripts, docker-compose should be sufficient for all migrations
- the document generator is still a manual step to add the template.
    - 
