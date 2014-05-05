#!/bin/bash
echo 'Killing old gollums...'
ps -ef | grep rackup | grep -v grep | awk '{print $2}' | xargs kill -9

if [ ! -f users.yml ] ; then
  echo "Create users.yml file and add users with 'rake add_user'!"
  exit 1
fi

if [ $(wc -m users.yml | awk '{print $1}') = '0' ] ; then
  echo "Add users with: bundle exec rake add_user[name, email, pass, can_write?(true/false)]!"
  exit 1
fi

echo 'Running gollum as daemon at port 4567 > log/gollum.log...'
# Pipe output to /dev/null for NO log
nohup bundle exec rackup -p 4567 config.ru > log/gollum.log &