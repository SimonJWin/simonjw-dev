package "build-essential" #Required for ruby-shadow
gem_package "ruby-shadow" # Required for password below

ruby_block "require shadow library" do
  block do
    Gem.clear_paths  # <-- Necessary to ensure that the new library is found
    require 'shadow' # <-- gem is 'ruby-shadow', but library is 'shadow'
  end
end

user node["username"] do
  comment "The required user for the VM"
  home node["home_dir"]
  shell "/bin/bash"
  password node["password-shadow"]
  action :create #Which is also "update"
end

directory node["home_dir"] do
	owner node["username"]
	group node["username"]
	mode 00755
	action :create
end

directory node["home_dir"] + "/bin" do
  owner node["username"]
  group node["username"]
  mode 00755
  action :create
end

group "sudo" do
  action :modify
  members node["username"]
  append true
end
template node["home_dir"] + "/.profile" do
  owner node["username"]
  source "profile.erb"
  mode 0644
end
template node["home_dir"] + "/.bashrc" do
  owner node["username"]
  source "bashrc.erb"
  mode 0644
end
template node["home_dir"] + "/.dircolors" do
  owner node["username"]
  source "dircolors.erb"
  mode 0644
end
template node["home_dir"] + "/.toprc" do
  owner node["username"]
  source "toprc.erb"
  mode 0644
end
