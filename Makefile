# helper Makefile for RAMS development

info:
	( \
	sum="|"; \
	for dir in `ls ./src`; do \
		msg="Plugin: $$dir"; \
		msg="$$msg $$(git -C src/$$dir rev-parse --short HEAD)"; \
		msg="$$msg $$(git -C src/$$dir branch | sed -n '/\* /s///p')"; \
		[[ ! -z `git -C src/$$dir ls-files --others --exclude-standard` ]] \
			&& msg="$$msg DIRTY" || msg="$$msg CLEAN"; \
		sum="$$sum $$msg |"; \
	done; \
	echo "$$sum"; \
	echo "//robohash.org/"`echo "$$sum" | md5`; \
	)
