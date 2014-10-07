# dockerfile for nplol.com
FROM nicohvi/webserver

# add 'app' user which will run the application
RUN adduser app 

# add separate gemfile to bundle in specific folder
ADD Gemfile       /var/www/
ADD Gemfile.lock  /var/www/
RUN chown -R app:app /var/www && \
  mkdir -p /var/bundle &&\
  chown -R app:app /var/bundle

RUN su -c "cd /var/www && bundle install --without development, test --path /var/bundle" -s /bin/bash -l app

# add source code
ADD . /var/www
RUN chown -R app:app /var/www

# run the subsequent commands as user *app* in dir *workdir*
USER app
WORKDIR /var/www

CMD 'RAILS_ENV=production rake assets:precompile' -s /bin/bash -l app

# add custom config to nginx
ADD ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

ENTRYPOINT sudo /etc/init.d/nginx start
