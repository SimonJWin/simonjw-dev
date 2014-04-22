#!/bin/bash
cd ~/chef
apt-get update
aptitude install -y ruby ruby1.8-dev build-essential wget libruby1.8 rubygems
gem update --no-rdoc --no-ri
gem install ohai chef --no-rdoc --no-ri
chef-solo -c ~/chef/solo.rb