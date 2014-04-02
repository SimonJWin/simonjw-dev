# RESTy, for easily using CURL to query the command line.
execute "resty" do
	user node["username"]
	command "curl -L http://github.com/micha/resty/raw/master/resty > " + node["home_dir"] + "/.restyf"
	creates node["home_dir"] + "/.restyf"
	action :run
end

# JQ, for easily parsing JSON from a curl
execute "jq" do
	user node["username"]
	jq_url = node['kernel']['machine'] =~ /x86_64/ ?
	         "http://stedolan.github.io/jq/download/linux64/jq" :
	         "http://stedolan.github.io/jq/download/linux32/jq"
	command "curl -L #{jq_url} > " + node["home_dir"] + "/bin/jq"
	creates node["home_dir"] + "/bin/jq"
	action :run
	notifies :touch, "file[" + node["home_dir"] + "/bin/jq]"
end

file node["home_dir"] + "/bin/jq" do
	action :nothing
	owner node["username"]
	mode 0755
end

package "traceroute"

# SCApy, the python package creation tool
package "python-scapy"
# Wireshark
package "wireshark"