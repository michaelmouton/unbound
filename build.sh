#!/bin/sh


sudo docker run --privileged --rm tonistiigi/binfmt --install all

sudo docker buildx build --platform "linux/amd64" -t unbound_amd64 .
sudo docker buildx build --platform "linux/arm64" -t unbound_arm64 .
sudo docker buildx build --platform "linux/arm/v7" -t unbound_armv7 .
sudo docker buildx build --platform "linux/arm/v6" -t unbound_armv6 .

sudo docker tag unbound_amd64:latest michaelmouton/unbound:latest_amd64
sudo docker tag unbound_arm64:latest michaelmouton/unbound:latest_arm64
sudo docker tag unbound_armv7:latest michaelmouton/unbound:latest_armv7
sudo docker tag unbound_armv6:latest michaelmouton/unbound:latest_armv6

sudo docker push michaelmouton/unbound:latest_amd64
sudo docker push michaelmouton/unbound:latest_arm64
sudo docker push michaelmouton/unbound:latest_armv7
sudo docker push michaelmouton/unbound:latest_armv6

sudo docker rmi -f $(sudo docker images -aq | sort -u)
