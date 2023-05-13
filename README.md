# CLÚSTER MICROK8S DESPLEGADO CON VAGRANT

## Descripción

Este repositorio contiene los archivos necesarios para desplegar un clúster de Kubernetes con Microk8s usando Vagrant.

## Requisitos

Para poder desplegar el clúster es necesario tener instalado Vagrant y VirtualBox.

## Despliegue

- Para desplegar el clúster, ejecutar el siguiente comando:

```bash
make deploy
```

- Para parar las máquinas del clúster, ejecutar el siguiente comando:

```bash
make stop
```

- Para destruir el clúster, ejecutar el siguiente comando:

```bash
make destroy
```

- Para acceder a las máquinas, ejecutar el siguiente comando:

```bash
make ssh name=microk8s_1
make ssh name=microk8s_2
make ssh name=microk8s_3
```

## Descargar el kubeconfig para acceso remoto

- Para descargar el kubeconfig, ejecutar el siguiente comando **_dentro de la máquina master_**:

```bash
microk8s config > kubeconfig
```

- Una vez descargado en el master, copiar el fichero en tu ~/.kube/config del master y cambiar la IP en el apartado **_server_** por la IP del master.

### Instalar en Windows

Parece que ejecutar el comando 'make' en windows no esta incluido en el path por defecto.

Una vez descargado Vagrant de https://developer.hashicorp.com/vagrant/downloads y teniendo vagrant en el path, ejecutar:

```bash
vagrant up
```

para levantar las máquinas. 

Los comandos anteriormente puestos simplemente cambiarlos por "vagrant ssh microk8s_1", "vagrant stop", etc.
