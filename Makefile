
ifeq (, $(shell which vagrant))
$(error "No tienes vagrant instalado, considera instalarlo")
endif

ifeq (, $(shell which virtualbox))
$(error "No tienes virtualbox instalado, considera instalarlo")
endif

.PHONY: deploy stop destroy status ssh
.SILENT: deploy stop destroy status ssh

deploy:
	@echo "Iniciando cluster..."
	@vagrant up

stop:
	@echo "Parando cluster..."
	@vagrant halt

destroy:
	@echo "Destruyendo cluster..."
	@vagrant destroy -f

status:
	@echo "Estado de las máquinas"
	@vagrant status

ssh:
	@echo "Conectando a $(name)..."
	@vagrant ssh $(name)
