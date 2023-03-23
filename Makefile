all: generate deploy

generate:
	hexo g -d
deploy: generate
	rsync -avizh public/. root@jeekrs.com:/var/www/html
clean:
	hexo clean


