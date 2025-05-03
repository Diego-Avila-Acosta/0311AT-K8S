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

# Se crea el cluster si no existe. Si existe se lo borra y se crea nuevamente"
if ! minikube status --profile=web-deploy > /dev/null 2>/dev/null; then
	echo "Creando cluster de minikube"
	minikube start --profile=web-deploy --mount --mount-string="$PROJECT_URL:/mnt/static-website"
else
	echo "Borrando cluster de minikube"
	minikube delete --profile=web-deploy && echo "Cluster borrado correctamente"
	echo "Creando cluster de minikube"
	minikube start --profile=web-deploy --mount --mount-string="$PROJECT_URL:/mnt/static-website"
fi

#Aplicamos manifiestos
kubectl apply -R -f "$SCRIPT_DIR/manifests/."

echo "Script ejecutado correctamente"
echo "Para empezar a desarrollar, espere unos minutos y ejecute el comando: minikube service --profile=web-deploy nginx-service"
