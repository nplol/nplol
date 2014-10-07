# dockerfile for nplol.com
FROM nicohvi/app

# add Gemfile seperately and bundle to particular folder
RUN mkdir -p /var/app
ADD Gemfile       /var/app
ADD Gemfile.lock  /var/app
RUN chown -R app:app /var/app && \
  mkdir -p /var/bundle &&\
  chown -R app:app /var/bundle

RUN su -c "cd /var/www && bundle install --without development, test --path /var/bundle" -s /bin/bash -l app

# add source code
ADD . /var/app
RUN chown -R app:app /var/app

# run the subsequent commands as user *app* in dir *workdir*
USER app
WORKDIR /var/app

RUN 'RAILS_ENV=production rake assets:precompile'

# add custom config to nginx
ADD nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

# finally, start nginx
ENTRYPOINT sudo /etc/init.d/nginx start
