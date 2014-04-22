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
end
