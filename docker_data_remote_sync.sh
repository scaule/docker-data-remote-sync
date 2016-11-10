getLastDumpFileName() {
	ssh -p$SERVER_PORT $SERVER_USER@$SERVER_NAME "ls -t $SERVER_DIRECTORY$1 | head -n1"
}

applyRestore() {
	echo "use on restore $COMPOSE_PREFIX$1$COMPOSE_SUFFIX $2" 
        ./restore-docker.sh $COMPOSE_PREFIX$1$COMPOSE_SUFFIX $2
}

getDump() {
	echo "downloading dump for $1"
	scp -P$SERVER_PORT $SERVER_USER@$SERVER_NAME:$SERVER_DIRECTORY$1/$2 .
        if [ "$RESTORE_DATA" = true ]
        then
            applyRestore $1 $2
        fi
	mkdir -p "./data_current_file"
	echo $2 > "./data_current_file/$service"
}

compareLastDumpFileWithCurrent() {
	service=$1
	remote_file_name=$(getLastDumpFileName $service)

	if [ -f "./data_current_file/$service" ];
	then
		current_file_name=$(<"./data_current_file/$service")
		if [ "$current_file_name" != "$remote_file_name" ];
		then
			getDump $service $remote_file_name
		fi
	else
		getDump $service $remote_file_name
	fi
}

. docker_data_remote_sync.cfg
for i in "${CONTAINERS[@]}"
do
   :
   compareLastDumpFileWithCurrent "$i"
done
