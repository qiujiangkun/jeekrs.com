HOST=ubuntu@jeekrs.com
all: generate deploy

generate:
	hexo g -d
deploy:
	rsync -avizhu --delete public/. $(HOST):jeekrs.com
	ssh $(HOST) 'sudo rsync -avizhu jeekrs.com/. /var/www/html/'

clean:
	hexo clean


