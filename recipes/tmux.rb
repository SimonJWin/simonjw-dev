package "tmux" do
	action :install
end

template "/etc/tmux.conf" do
	source "tmux.conf.erb"
	mode 0644
end

