#!/bin/bash

set -e
set -o pipefail

SCRIPT_DIR="$(dirname "$0")"
PROJECT_URL="${PWD}/static-website"

#URL de la página por defecto
WEBSITE_URL="https://github.com/Diego-Avila-Acosta/static-website"

#Si el usuario provee su propio repositorio website
WEBSITE_URL="${1:-$WEBSITE_URL}"

#Funcion para verificar dependencias
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


if [ ! -d "${PROJECT_URL}/.git" > /dev/null ]; then
	echo "Repositorio no encontrado. Clonando repositorio de $WEBSITE_URL"
	git clone $WEBSITE_URL
else
	echo "Repositorio ya existente. Actualizando"
	cd "static-website" && git pull && cd ..
fi
