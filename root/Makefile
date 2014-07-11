install:
	echo "installing dependencies..."; \
	npm install uglify-js -g; \
	npm install clean-css -g; \
	npm install jade -g; \
	npm install coffee -g; \
	bower install; \
	echo "done!"; \

build:
	@echo "compiling..."
	@rm <% name %>.html
	@rm <% name %>.css
	@jade < /src/<% name %>.jade > ./<% name %>.html
	@coffee < /src/<% name %>.coffee -o ./<% name %>.js
	@echo "done!"

@PHONY .install
