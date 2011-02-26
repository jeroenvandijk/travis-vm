user "runner"

# Add vagrant to group of runner so it can go there
# Install RVM under the runner user
# Backup the home dir of runner

Add to put the following line under auto wlan0 or auto eth0 in /etc/network/interfaces
    
    pre-up iptables -A OUTPUT -p tcp -m owner --uid-owner username -j DROP

run command:

    sudo iptables -A OUTPUT -p tcp -m owner --uid-owner username -j DROP
