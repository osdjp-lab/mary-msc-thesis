# Makefile for LaTeX thesis

PROJECT = thesis

all: build

build:
	latexmk -pdf -pdflatex="pdflatex -file-line-error -interaction=errorstopmode" -verbose -use-make $(PROJECT).tex

clean:
	latexmk -CA
	rm -f $(PROJECT).bbl $(PROJECT).run.xml $(PROJECT).acn $(PROJECT).acr $(PROJECT).alg $(PROJECT).glg $(PROJECT).glo $(PROJECT).gls $(PROJECT).ist

watch:
	latexmk -pvc -pdf -pdflatex="pdflatex -file-line-error -interaction=errorstopmode" -verbose -use-make $(PROJECT).tex

.PHONY: all build clean watch
