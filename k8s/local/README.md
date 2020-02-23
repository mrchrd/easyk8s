# Requirements

- [Minikube](https://github.com/kubernetes/minikube/releases)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) or other supported hypervisor
- [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

# Usage

## Cluster Creation

```
export KUBECONFIG="${PWD}/kubeconfig"
minikube start
```

## Try kubectl

```
kubectl get pods -A
```

## Cleanup

```
minikube delete
```

# References

- [Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/)
