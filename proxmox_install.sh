#!/bin/bash

# Vérification des droits root
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être exécuté en tant que root" 
   exit 1
fi

# Ajout du dépôt Proxmox VE
echo "deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list

# Ajout de la clé GPG du dépôt
wget http://download.proxmox.com/debian/proxmox-ve-release-7.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-7.x.gpg

# Mise à jour des paquets
apt-get update

# Installation de Proxmox VE
apt-get install -y proxmox-ve postfix open-iscsi

# Démarrage des services Proxmox VE
systemctl start pve-cluster.service
systemctl start pvedaemon.service
systemctl start pveproxy.service

# Activation des services au démarrage
systemctl enable pve-cluster.service
systemctl enable pvedaemon.service
systemctl enable pveproxy.service

# Affichage du message de fin d'installation
echo "Proxmox VE a été installé avec succès sur Debian 11 Bullseye."
echo "Vous pouvez accéder à l'interface web de Proxmox VE à l'adresse suivante : https://<IP du serveur>:8006"
