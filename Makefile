NDE_NAME=hugo

update:
	git submodule sync
	git submodule update --recursive

run:
	docker run --privileged -h  ${NDE_NAME} --name ${NDE_NAME} -d --cap-add=SYS_PTRACE \
	   --net=host \
	   --add-host ${NDE_NAME}:127.0.0.1 \
	   --env HOME=/home/${USER} \
	   --env USER=${USER} \
	   --env GROUP=${USER} \
	   --env USER_ID=`id -u ${USER}` \
	   --env GROUP_ID=`getent group nubot | awk -F: '{printf $$3}'` \
	   --env EMAIL \
	   --env GIT_AUTHOR_EMAIL \
	   --env GIT_AUTHOR_NAME \
	   --env GIT_COMMITTER_EMAIL \
	   --env GIT_COMMITTER_NAME \
	   --env SSH_AUTH_SOCK \
	   --env TERM \
	   --env DISPLAY \
	   --env VIDEO_GROUP_ID=`getent group video | awk -F: '{printf $$3}'` \
	   --volume $${PWD%/*}:/home/${USER} \
	   --volume /dev/dri:/dev/dri \
	   --gpus all \
	   --env NVIDIA_VISIBLE_DEVICES=all \
	   --env NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics,display \
	   --env LD_LIBRARY_PATH=/usr/local/nvidia/lib64 \
	   nubonetics/hugo-node:latest
