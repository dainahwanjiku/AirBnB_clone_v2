#!/usr/bin/env bash
# sets up the web servers for the deployment of web_static

# install nginx server if not installed already
sudo apt-get update
sudo apt-get -y install nginx

# create required folders if not exists already
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared

# simple html to test nginx configuration
echo "This is a test" | sudo tee /data/web_static/releases/test/index.html

# create symbolic link, override if already exists
sudo ln -sfn /data/web_static/releases/test/ /data/web_static/current

# give ownership of /data/ to user and group
sudo chown -R ubuntu:ubuntu /data/

# update nginx config to serve content of /data/web_static/current
sudo sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

sudo service nginx restart
