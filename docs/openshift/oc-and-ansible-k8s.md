# oc and Ansible k8s

## oc

RedHat provide several CLIs to interact with OpenShift.

## Ansible k8s 

Ansible supports working with Kubernetes via the k8s modules. These were included with Ansible up to v2.9 but when v2.10 is released this will need to be installed using the [community kubernetes collection](https://galaxy.ansible.com/community/kubernetes). Either way, this provides a  potentially idempotent way to manage resources in Kubernetes. I say potentially because it's still possible to unintentionally use these modules in a non-idempotent manner, more on that later. 

## Convert oc CLI commands to Ansible k8s

It may not be immediately apparent what K8s resources need to be created to provide parity with oc commands. Here is a rough guide to what you'll need to create with k8s in order to replicate oc commands. Note as always that when writing or updating automation, simply automating exactly what came before is not always optimal especially if the process being automated was manual. 

`oc new-app` - DeploymentConfig, ReplicationController, ImageStream, BuildConfig, Service

`oc expose` - Route

`oc secrets link` - ServiceAccount update to add linked secret

`oc import-image` - ImageStream

`oc new_build` - BuildConfig
