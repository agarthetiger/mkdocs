# oc and Ansible k8s

## oc

RedHat provide several CLIs to interact with OpenShift. With OpenShift 4.4 these include

* [oc](https://docs.openshift.com/container-platform/4.4/cli_reference/openshift_cli/getting-started-cli.html) - An operations-focussed tool for managing OpenShift clusters.
* [odo](ahttps://docs.openshift.com/container-platform/4.4/cli_reference/developer_cli_odo/understanding-odo.html) - OpenShift Do, a developer-focussed tool for developing applications with OpenShift, intentionally abstracting away the complexities of OpenShift and Kubernetes. 
* [tkn](https://docs.openshift.com/container-platform/4.4/cli_reference/tkn_cli/installing-tkn.html) - Tekton CLI for interacting with Tekton, the Kubernetes-native build tool behind OpenShift Pipelines. 
* [kn](https://docs.openshift.com/container-platform/4.4/serverless/knative_cli/knative-cli.html#knative-cli) - Knative CLI for interacting with OpenShift Serverless.


## Ansible k8s 

Ansible supports working with Kubernetes via the k8s modules. These were included with Ansible up to v2.9 but when v2.10 is released this will need to be installed using the [community kubernetes collection](https://galaxy.ansible.com/community/kubernetes). Either way, this provides a  potentially idempotent way to manage resources in Kubernetes. I say potentially because it's still possible to unintentionally use these modules in a non-idempotent manner, more on that later. 

Ansible 2.7 through to 2.9 has seen additions to the k8s family of modules including `k8s_auth`, `k8s_service` and `k8s_info`, as well as enhancements like the addition of `wait`, `wait_timeout` and `wait_condition` to the k8s module. This [Ansible blog post](https://www.ansible.com/blog/continuous-improvements-in-ansible-and-kubernetes-automation) provides some more details. 

## Convert oc CLI commands to Ansible k8s

It may not be immediately apparent what K8s resources need to be created to provide parity with oc commands. Here is a rough guide to what you'll need to create with k8s in order to replicate oc commands. Note as always that when writing or updating automation, simply automating exactly what came before is not always optimal especially if the process being automated was manual. 

`oc new-app` - DeploymentConfig, ReplicationController, ImageStream, BuildConfig, Service

`oc expose` - Route

`oc secrets link` - ServiceAccount update to add linked secret

`oc import-image` - ImageStream

`oc new_build` - BuildConfig
