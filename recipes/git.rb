case node['platform_family']
when "debian"
  if node['platform'] == "ubuntu" && node['platform_version'].to_f < 10.10
    package "git-core"
  else
    package "git"
  end
else
  package "git"
end

template "/etc/gitconfig" do
	source "gitconfig.erb"
	mode 0644
end

template node["home_dir"] + "/.gitignore" do
  owner node["username"]
	source "gitignore.erb"
	mode 0644
end
