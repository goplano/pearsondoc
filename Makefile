BASE_NAME=index

all: $(BASE_NAME).html $(BASE_NAME).pdf  $(BASE_NAME).epub $(BASE_NAME).md

$(BASE_NAME).html: prepare
	asciidoctor src/$(BASE_NAME).adoc -o dist/$(BASE_NAME).html



$(BASE_NAME).pdf: prepare
	asciidoctor -r asciidoctor-pdf -b pdf src/$(BASE_NAME).adoc -o output/$(BASE_NAME).pdf

$(BASE_NAME).xml: prepare
	asciidoctor -b docbook5 -d article src/$(BASE_NAME).adoc -o output/$(BASE_NAME).xml

$(BASE_NAME).epub: $(BASE_NAME).xml
	pandoc -f docbook -t epub3 output/$(BASE_NAME).xml -o output/$(BASE_NAME).epub

$(BASE_NAME).docx: $(BASE_NAME).xml
	pandoc -f docbook -t docx output/$(BASE_NAME).xml -o output/$(BASE_NAME).docx

$(BASE_NAME).md: prepare $(BASE_NAME).xml
	pandoc -f docbook -t markdown_github -s --toc output/$(BASE_NAME).xml -o output/$(BASE_NAME).md

prepare:
	mkdir -p output
	mkdir -p output/img
	mkdir -p dist
	mkdir -p dist/img
	cp src/img/* dist/img
	cp src/img/* output/img