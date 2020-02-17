# base image
FROM node:12.13.0

ARG DEBIAN_FRONTEND=noninteractive
ARG ENV_TZ

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
    NG_CLI_ANALYTICS=ci

# install chrome for protractor tests
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && \
    apt-get install -yq apt-utils google-chrome-stable && \
# prevent pre/post-install hooks on packages
    npm config set ignore-scripts true 

RUN if [ -z "$ENV_TZ"]; \
    then echo "timezone argument is empty - not setting" ; \
    else ln -snf /usr/share/zoneinfo/$ENV_TZ /etc/localtime && echo $ENV_TZ > /etc/timezone; \
    fi


# start app
CMD tail -f /dev/null
#CMD ng serve --host 0.0.0.0 --watch="true" --poll 100
