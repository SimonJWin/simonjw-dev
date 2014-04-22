package "cpanminus"
package "libcurses5-dev"
execute "Installing Perl modules..." do
	command "cpanm --sudo Term::Animation"
  action :run
end

execute "Install the asciiquarium" do
  user node["username"]
  command "curl -L https://raw.githubusercontent.com/cmatsuoka/asciiquarium/master/asciiquarium > " + node["home_dir"] + "/bin/asciiquarium"
  creates node["home_dir"] + "bin/asciiquarium"
  action :run
  notifies :touch, "file[" + node["home_dir"] + "/bin/asciiquarium]"
end

file node["home_dir"] + "/bin/asciiquarium" do
  action :nothing
  owner node["username"]
  mode 0755
end
