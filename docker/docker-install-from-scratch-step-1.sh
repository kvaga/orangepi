#/bin/bash
echo "Remove old docker installations"
sudo apt remove -y docker docker-engine docker.io containerd runc

echo "Installation of certs, curl, gnupg, lsb-release"
sudo apt update &&
sudo apt-get install -y ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update 
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo Note: If an error is reported after Debian Buster is installed, please enter thefollowing command to solve it:
echo ---: orangepi@orangepi:~$ echo 1 | update-alternatives --config iptables > /dev/null
echo ---: orangepi@orangepi:~$ sudo systemctl restart docker
echo Add user to 'docker' group
sudo usermod -aG docker $USER
echo Exit. Please relogin again and start from 
