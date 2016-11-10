# docker-data-remote-sync

This project help to save and share docker volume by containers name. We provide some script to backup/restore containers volumes and download/restore last backup from a remote server by container name. 

# Backup 

If you want to backup a docker container volume you only have to use this command : 

Exemple:

./docker_backup.sh container_name 

This command create a tar.gz file with your datas.

Backup format exemple: 
container_name_2016-11-04T08:54:52.tar.gz

# Restore

To restore data on your container you only have to call restore script with your container name and the file of your choice.

Exemple:

./docker_backup.sh container_name container_name_2016-11-04T08:54:52.tar.gz

# Remote sync with fresh data

We provide a tool for download and restore automaticly your data for your containers. 
To use this script you have to set your server informations and containers on docker_data_remote_sync.cfg.

When configuration is ok, you only have to execute docker_data_remote_sync.sh and he will connect to your server and looking for the last backup for each containers on config file.

If you want to only download and not restore you can set the RESTORE_DATA parameter to false. 

On server side you have to create a folder for all container backups and a folder on it for each container with container name for exemple :

* /here/server/directory/container1
* /here/server/directory/container2
* /here/server/directory/container3

Warning : 
* (Security) To prevent server password on config file we only use authentification by ssh key.

Contributor : 
* @masev 
Special thanks for backup script from quadeare : 
https://github.com/quadeare/docker_volumes_backup/blob/master/backup-docker.sh 
