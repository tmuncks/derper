name = derper

# define major version
# FIXME: determine and tag latest version number
#export version = 1.0

check_latest:
	# determine latest version of $(name)

build:
	# build image
	docker pull golang:alpine
	docker pull alpine:latest
	cd docker && docker build . --no-cache -t tmuncks/$(name):latest
	#docker tag tmuncks/$(name):latest tmuncks/$(name):$(version)

push:
	# publish image
	docker push tmuncks/$(name):latest
	#docker push tmuncks/$(name):$(version)

