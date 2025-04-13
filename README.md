
# Deploy de Página Web Estática

## Pre-Requisitos

1. Sistema Operativo: Linux (Testeado en Ubuntu)
2. minikube
3. Git
4. Docker (u otro container manager)
5. kubectl

## Instrucciones

1. Clonamos este repositorio con los manifiestos:

```bash
git clone https://github.com/Diego-Avila-Acosta/0311AT-K8S
```

2. Clonamos el repositorio de la página estática:

```bash
git clone https://github.com/Diego-Avila-Acosta/static-website.git
```

3. Iniciamos un cluster de minikube:

```bash
minikube start --mount --mount-string="${PWD}/static-website:/mnt/static-website"
```

4. Aplicamos los manifiestos del primer repositorio clonado:

```bash
kubectl apply -f 0311AT-K8S/manifests/.
```

5. Ejecutamos el siguiente comando para acceder al servicio

```bash
minikube service nginx-service
```

6. Entramos a la URL que nos da la terminal. Ej: http://127.0.0.1:34377
7. Ya se debería de poder ver la página web estática.
8. A partir de otra terminal cambiar el contenido del index.html y verificar que se hayan actualizado los cambios refrescando el navegador.