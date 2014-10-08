# dockerfile for nplol.com
FROM nicohvi/app

# add Gemfile seperately and bundle to particular folder
ADD Gemfile       /var/app/
ADD Gemfile.lock  /var/app/
RUN chown -R app:app /var/app && \
  mkdir -p /var/bundle &&\
  chown -R app:app /var/bundle

WORKDIR /var/app

RUN /bin/bash -c -l app  "bundle install --without development, test --path /var/bundle"

# add source code
ADD . /var/app/
RUN chown -R app:app /var/app

USER app
RUN /bin/bash -c -l  'RAILS_ENV=production bundle exec rake assets:precompile
'

# add custom config to nginx
ADD nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

# finally, start nginx
ENTRYPOINT sudo /etc/init.d/nginx start
