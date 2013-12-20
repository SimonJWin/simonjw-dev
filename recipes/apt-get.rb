# Trying to avoid having to include the apt cookbook in full, just a minimal snippet...
# First ever apt-get update if needed
execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  not_if do ::File.exists?('/var/lib/apt/periodic/update-success-stamp') end
end

# provides /var/lib/apt/periodic/update-success-stamp on apt-get update
package "update-notifier-common" do
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

# Do apt-get update daily if needed
execute "apt-get-update-periodic" do
  command "apt-get update"
  ignore_failure true
  only_if do
    ::File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    ::File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end