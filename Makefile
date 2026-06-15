# Makefile for LaTeX thesis

PROJECT = thesis

all: build

build:
	latexmk -pdf -pdflatex="pdflatex -file-line-error -interaction=errorstopmode" -verbose -use-make $(PROJECT).tex

odt:
	pandoc thesis.tex --from=latex --to=odt --output=thesis.odt --citeproc --bibliography=8-bibliografia.bib

docx:
	pandoc thesis.tex --from=latex --to=docx --output=thesis.docx --citeproc --bibliography=8-bibliografia.bib --csl=vancouver.csl

clean:
	latexmk -CA
	rm -f $(PROJECT).bbl $(PROJECT).run.xml $(PROJECT).acn $(PROJECT).acr $(PROJECT).alg $(PROJECT).glg $(PROJECT).glo $(PROJECT).gls $(PROJECT).ist

watch:
	latexmk -pvc -pdf -pdflatex="pdflatex -file-line-error -interaction=errorstopmode" -verbose -use-make $(PROJECT).tex

.PHONY: all build clean watch
