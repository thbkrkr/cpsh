
dev:
	docker run -ti \
		-p 1234:4242 \
		-e CPL_API=${CPL_API} \
		-v $$(pwd)/api:/api \
		krkr/apish