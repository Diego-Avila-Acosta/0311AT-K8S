#!/bin/bash

verify_dependecies(){
	if ! which $1 > /dev/null; then
		echo "Error: Se requiere '$1' pero no está instalado o no está en el PATH." >&2
		exit 1
	fi
}

verify_dependecies git
verify_dependecies docker
verify_dependecies minikube
verify_dependecies kubectl
