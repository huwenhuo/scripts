all: 
	rsync -avur ./ huw@luna.mskcc.org:~/program/fun/
up: 
	rsync -avur ./ huw@luna.mskcc.org:~/program/fun/
dn: 
	rsync -avur huw@luna.mskcc.org:~/program/fun/ ./
