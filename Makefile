
img := gcr.io/istio-testing/website-builder:2018-06-15
docker := docker run -t -i --sig-proxy=true --rm -v $(shell pwd):/site -w /site $(img)

build:
	$(docker) scripts/build_site.sh

gen:
	$(docker) scripts/gen_site.sh ""

lint:
	$(docker) scripts/lint_site.sh

serve:
	docker run -t -i --sig-proxy=true --rm -v $(shell pwd):/site -w /site -p 1313:1313 $(img) hugo serve --bind 0.0.0.0 --disableFastRender

netlify:
	npm install -g html-minifier
	scripts/gen_site.sh "$(DEPLOY_PRIME_URL)"
