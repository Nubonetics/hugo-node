NDE_NAME=hugo

update:
	git submodule sync
	git submodule update --recursive

docker-update:
	docker pull nubonetics/hugo-node:latest

run:
	docker run --privileged -h  ${NDE_NAME} --name ${NDE_NAME} -d --cap-add=SYS_PTRACE \
	   --net=host \
	   --add-host ${NDE_NAME}:127.0.0.1 \
	   --env EMAIL \
	   --env GIT_AUTHOR_EMAIL \
	   --env GIT_AUTHOR_NAME \
	   --env GIT_COMMITTER_EMAIL \
	   --env GIT_COMMITTER_NAME \
	   --env SSH_AUTH_SOCK \
	   --env TERM \
	   --env DISPLAY \
	   --volume $${PWD}:/workspace \
	   --volume /dev/dri:/dev/dri \
	   nubonetics/hugo-node:latest

enter:
	docker exec -it -w /workspace ${NDE_NAME} /bin/bash

stop:
	docker stop ${NDE_NAME}
	docker rm ${NDE_NAME}
