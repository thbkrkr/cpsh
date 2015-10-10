build:
	docker build --rm -t krkr/curlaas .

#

dev:
	docker run -ti \
		-p 1234:4242 \
		-e CPL_API=${CPL_API} \
		-v $$(pwd)/api:/api \
		krkr/apish

#

local-run:
	docker run -d --name curlaas \
		-p 1234:4242 \
		-e CPL_API=${CPL_API} \
		krkr/curlaas

run:
	docker run -d --name curlaas \
		-p 80:4242 \
		-e CPL_API=${CPL_API} \
		krkr/curlaas

rm:
	docker rm -f curlaas

#

prod: tag push redeploy

sail-add:
	sail services add krkr/curlaas curlaas \
		-e CPL_API=http://curlaas.krkr.app.sailabove.io \
		--publish 4242:80 \
		--batch=true

tag:
	docker tag -f krkr/curlaas sailabove.io/krkr/curlaas

push:
	docker push sailabove.io/krkr/curlaas


redeploy:
	sail services redeploy curlaas \
		-e CPL_API=http://curlaas.krkr.app.sailabove.io \
		--publish 4242:80 \
		--batch=true