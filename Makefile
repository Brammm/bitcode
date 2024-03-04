.PHONY: build
build:
	docker-compose build --pull && \
	docker-compose push

DOCKER_TUNNEL_CONTAINER=docker_swarm_ssh_tunnel
DOCKER_TUNNEL_PORT=12374
DOCKER_SWARM_HOST=174.138.10.79
DEPLOY_USER=root
DOCKER_STACK_FILE=env/prod/docker-compose.yml
DOCKER_STACK_NAME=brammm

.PHONY: deploy
.SILENT: deploy
deploy: \
	tunnel-to-production-docker-socket
	docker \
		-H localhost:$(DOCKER_TUNNEL_PORT) \
		stack deploy \
		--with-registry-auth \
		-c $(DOCKER_STACK_FILE) \
		--prune \
		$(DOCKER_STACK_NAME)

.SILENT: tunnel-to-production-docker-socket
tunnel-to-production-docker-socket:
	# Create SSH tunnel to Docker Swarm cluster
	@(docker ps | grep $(DOCKER_TUNNEL_CONTAINER)) || docker run \
		-d \
		--name $(DOCKER_TUNNEL_CONTAINER) \
		-p $(DOCKER_TUNNEL_PORT):$(DOCKER_TUNNEL_PORT) \
		-v $(HOME)/.ssh:/root/.ssh \
		kingsquare/tunnel \
		*:$(DOCKER_TUNNEL_PORT):/var/run/docker.sock \
		$(DEPLOY_USER)@$(DOCKER_SWARM_HOST)

	$(MAKE) wait-for-tunnel-to-production-docker-socket

wait-for-tunnel-to-production-docker-socket:
	until docker -H localhost:$(DOCKER_TUNNEL_PORT) version 2>/dev/null 1>/dev/null > /dev/null; do
		echo "Waiting for docker tunnel";
		sleep 1;
	done
