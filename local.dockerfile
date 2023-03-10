FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

COPY ./localrubyscript.sh/ /usr/local/bin/rubyscript.sh
RUN chmod +x /usr/local/bin/rubyscript.sh

RUN apt-get update
RUN apt-get install git curl -y 
RUN curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
RUN bash /tmp/nodesource_setup.sh
RUN apt-get install nodejs -y
RUN npm install -g yarn

RUN apt-get install -y git autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
RUN apt-get install -y postgresql-contrib
RUN apt-get install -y libpq-dev

RUN useradd -ms /bin/bash rubyuser
USER rubyuser
WORKDIR /home/rubyuser/
COPY . .

RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo $PATH
# RUN $PATH
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN bash -l -c 'source ~/.bashrc'

# CMD [ "/bin/bash" ]
RUN bash -l -c '~/.rbenv/bin/rbenv install 3.0.2'
RUN bash -l -c '~/.rbenv/bin/rbenv global 3.0.2'


EXPOSE 3000
ENTRYPOINT ["rubyscript.sh"]
