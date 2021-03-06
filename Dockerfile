# dockerfile for nplol.com
FROM nicohvi/app

# add Gemfile seperately and bundle to particular folder
ADD Gemfile       /var/app/
ADD Gemfile.lock  /var/app/
RUN chown -R app:app /var/app && \
  mkdir -p /var/bundle &&\
  chown -R app:app /var/bundle

RUN su app -c "cd /var/app && bundle install --without development, test --path /var/bundle" -l

# add source code
ADD . /var/app/
RUN chown -R app:app /var/app

RUN su app -c 'cd /var/app && RAILS_ENV=production bundle exec rake assets:precompile' -l

# add custom config to nginx
ADD nginx.conf /etc/nginx/nginx.conf

VOLUME ["/var/log"]
