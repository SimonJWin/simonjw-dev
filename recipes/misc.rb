# Install ncurses-term to get terminal color definitions - in particular, for putty in 256 colors!
# 
# To take advantage of this, setup Putty correctly:
# http://blog.sanctum.geek.nz/putty-configuration/
package "ncurses-term"

# The generic log colorizer
package "grc"
package "build-essential"
package "cmake"
package "curl"
package "sudo"
if node["platform"] == "ubuntu" and node["platform_version"].to_f > 13.10
  package "silversearcher-ag"
else
  package "automake"
  package "pkg-config"
  package "libpcre3-dev"
  package "zlib1g-dev"
  package "liblzma-dev"

  execute "clone_silver_searcher" do
    user node["username"]
    command "git clone https://github.com/ggreer/the_silver_searcher.git " + node["home_dir"] + "/.the_silver_searcher.git"
    not_if do ::File.directory?(node["home_dir"] + '/.the_silver_searcher.git') end
    notifies :run, "execute[build_silver_searcher]"
    action :run
    # [SJW] Chef-solo doesn't setup environment correctly.  Work around.
    # http://tickets.opscode.com/browse/CHEF-2288
	  environment ({'HOME' => node["home_dir"], 'USER' => node["username"]})
  end

  execute "build_silver_searcher" do
    user node["username"]
    cwd node["home_dir"] + "/.the_silver_searcher.git"
    command "./build.sh"
    timeout 60
    action :nothing
    notifies :run, "execute[install_silver_searcher]"
    # [SJW] Chef-solo doesn't setup environment correctly.  Work around.
    # http://tickets.opscode.com/browse/CHEF-2288
	  environment ({'HOME' => node["home_dir"], 'USER' => node["username"]})
  end

  execute "install_silver_searcher" do
    cwd node["home_dir"] + "/.the_silver_searcher.git"
    command "make install"
    timeout 60
    action :nothing
    # [SJW] Chef-solo doesn't setup environment correctly.  Work around.
    # http://tickets.opscode.com/browse/CHEF-2288
	  environment ({'HOME' => node["home_dir"], 'USER' => node["username"]})
  end
end
