FROM python:3.8.8
LABEL version="latest" maintainer="Shambukameshwar <shambu@cogniwide.com>"

#update the image
RUN apt-get update

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# set display port to avoid chrome crash
ENV DISPLAY=:99

# Installing Oracle instant client
WORKDIR    /opt/oracle
RUN apt-get update && apt-get install -y libaio1 wget unzip \
            && wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip \
            && unzip instantclient-basiclite-linuxx64.zip \
            && rm -f instantclient-basiclite-linuxx64.zip \
            && cd /opt/oracle/instantclient* \
            && rm -f *jdbc* *occi* *mysql* *README *jar uidrvci genezi adrci \
            && echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf \
            && ldconfig


#work directory setup
RUN mkdir /robot
RUN mkdir /results
WORKDIR /robot

RUN python -m pip install --upgrade pip

RUN pip install -U robotframework-csvlibrary

# copying the baselibraries.txt file
COPY baselibraries.txt /robot/baselibraries.txt

#install baselibraries
#RUN pip install robotframework-pabot
RUN pip install -r baselibraries.txt

COPY . .

WORKDIR /robot/APP

#Robot Specific
#ENTRYPOINT ["robot"]

CMD ["sh", "-c", "/robot/bin/entrypoint.sh"]