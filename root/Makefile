install:
	echo "installing dependencies..."; \
	npm install uglify-js -g; \
	npm install clean-css -g; \
	npm install jade -g; \
	npm install coffee -g; \
	bower install; \
	echo ""; \

build:
	@echo "compiling..."
	@jade < <% name %>.jade > <% name %>.html
	@coffee < <% name %>.coffee -o <% name %>.js
	@echo "done!"

@PHONY .install
