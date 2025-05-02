#!/bin/bash

set -e
set -o pipefail

WEBSITE_URL="https://github.com/Diego-Avila-Acosta/static-website"

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


if [ ! -d "./static-website/.git" > /dev/null ]; then
	echo "Repositorio no encontrado. Clonando..."
	git clone $WEBSITE_URL
else
	echo "Repositorio ya existente. Actualiznado"
	cd "static-website"
	git pull
fi
