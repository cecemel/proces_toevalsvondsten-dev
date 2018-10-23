FROM python:2.7

RUN apt-get update
RUN apt-get install -y libgeos-c1 libgeos-3.4.2
RUN apt-get install -y imagemagick
RUN pip install sphinx
RUN apt-get install -y ghostscript
COPY requirements.txt /app/
COPY requirements-dev.txt /app/

WORKDIR "/app/"
ARG GITUSER="USERNAME_NEEDED"
ARG GITPW="PASSWORD_NEEDED"
# TODO: fix this in a proper settings file
RUN pip install -e git+https://$GITUSER:$GITPW@github.com/OnroerendErfgoed/oeauth.git@0.2.6#egg=oeauth
RUN pip install -r requirements.txt
RUN pip install -r requirements-dev.txt
COPY . /app

RUN python setup.py install
CMD python scripts_local/proces_toevalsvondsten_daemon.py
