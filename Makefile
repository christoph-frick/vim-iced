.PHONY: all vital test themis lint clean repl doc

PLUGIN_NAME = iced
VITAL_MODULES = Data.Dict \
								Data.List \
								Data.String \
								Vim.Buffer \
								Vim.BufferManager \
								Vim.Message \
								Web.HTTP

all: vital test

vital:
	vim -c "Vitalize . --name=$(PLUGIN_NAME) $(VITAL_MODULES)" -c q

test: themis lint

.vim-themis:
	git clone https://github.com/thinca/vim-themis .vim-themis

themis: .vim-themis
	./.vim-themis/bin/themis

lint:
	find . -name "*.vim" | grep -v vital | grep -v .vim-themis | xargs vint

clean:
	/bin/rm -rf autoload/vital*

repl:
	clojure -A:dev -m iced-repl

doc:
	clojure -A:dev -m document
