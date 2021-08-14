FROM ubuntu:latest

# Chrome
RUN apt-get update
RUN apt-get autoclean
RUN apt install -y curl unzip
RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /chrome.deb
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y ./chrome.deb
RUN rm /chrome.deb

# Chrome driver
RUN export CHROMEMAJOR=$(google-chrome --product-version | awk -F. '{print $1}') && \
    export CDVERSION=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROMEMAJOR) && \
    curl https://chromedriver.storage.googleapis.com/"$CDVERSION"/chromedriver_linux64.zip -o chromedriver.zip
RUN unzip ./chromedriver.zip
RUN mv ./chromedriver /usr/local/bin/chromedriver
RUN chmod +x /usr/local/bin/chromedriver

# Python3 and pip
RUN apt install -y python3 python3-pip

CMD echo 'Worker Ready'
