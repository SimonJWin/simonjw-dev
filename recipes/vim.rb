package "vim"

template node["home_dir"] + "/.vimrc" do
  owner node["username"]
  source "vimrc.erb"
  mode 0644
  notifies :run, "execute[run_vundle_bundleinstall]"
end

execute "install_vundle" do
	user node["username"]
	command "git clone https://github.com/gmarik/vundle.git " + node["home_dir"] + "/.vim/bundle/vundle"
	not_if do ::File.directory?(node["home_dir"] + '/.vim/bundle/vundle') end
	notifies :run, "execute[run_vundle_bundleinstall]"
	action :run
	# [SJW] Chef-solo doesn't setup environment correctly.  Work around.
	# http://tickets.opscode.com/browse/CHEF-2288
	environment ({'HOME' => node["home_dir"], 'USER' => node["username"]})
end

execute "run_vundle_bundleinstall" do
	user node["username"]
	command "vim +BundleInstall +qall"
	timeout 60
	action :nothing

	# [SJW] Chef-solo doesn't setup environment correctly.  Work around.
	# http://tickets.opscode.com/browse/CHEF-2288
	environment ({'HOME' => node["home_dir"], 'USER' => node["username"]})
end

gem_package "teamocil"
