.PHONY: spin ssh ping provision up down migrate artisan schedule list create check

# Set dir of Makefile to a variable to use later
MAKEPATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PWD := $(dir $(MAKEPATH))
spin:
	cd infra/aws \
	&& terraform apply \
    && cd -

ping:
	ansible all -i infra/terraform.py/terraform.py -m ping --private-key=~/.ssh/aws/id_rsa

ssh:
	ssh -i "~/.ssh/aws/id_rsa" ec2-user@ec2-52-14-48-128.us-east-2.compute.amazonaws.com

provision:
	ansible-playbook infra/provision/ansible/provision.yml \
	-i infra/terraform.py/terraform.py \
	--private-key=~/.ssh/aws/id_rsa

up:
	docker-compose up --d

down:
	docker-compose down

migrate:
	docker run -it --rm \
	-v $(PWD)application:/opt \
	-w /opt \
	--network=up_appnet \
	shippingdocker/php \
	php artisan migrate

ART=""
art: artisan
artisan:
	docker run -it --rm \
	-v $(PWD)application:/opt \
	-w /opt \
	--network=up_appnet \
	shippingdocker/php \
	php artisan $(ART)

ls: list
list:
	docker run -it --rm \
	-v $(PWD)application:/opt \
	-w /opt \
	--network=up_appnet \
	shippingdocker/php \
	php artisan monitor:list

URL=""
create:
	docker run -it --rm \
	-v $(PWD)application:/opt \
	-w /opt \
	--network=up_appnet \
	shippingdocker/php \
	php artisan monitor:create $(URL)

delete:
	docker run -it --rm \
	-v $(PWD)application:/opt \
	-w /opt \
	--network=up_appnet \
	shippingdocker/php \
	php artisan monitor:delete $(URL)

schedule:
	docker run -it --rm \
	-v $(PWD)application:/opt \
	-w /opt \
	--network=up_appnet \
	shippingdocker/php \
	php artisan schedule:run

check:
	docker run -it --rm \
	-v $(PWD)application:/opt \
	-w /opt \
	--network=up_appnet \
	shippingdocker/php \
	php artisan monitor:check-uptime

