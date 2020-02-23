TAG := docker.io/mrchrd/hello:latest

.PHONY: build
build:
	docker build -t "${TAG}" .

.PHONY: push
push:
	docker push "${TAG}"

.PHONY: deploy
deploy:
	kubectl apply -f hello.yaml

.PHONY: port-forward
port-forward:
	kubectl port-forward svc/hello 8080:80 &

.PHONY: test
test:
	curl -s http://localhost:8080/friend | jq .

.PHONY: clean
clean:
	kubectl delete -f hello.yaml
	docker rmi "${TAG}"
