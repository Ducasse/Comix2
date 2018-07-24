"
By default iterate over original items. 
"
Class {
	#name : #CXAbstractLaTeXPrinter,
	#superclass : #CXTools,
	#instVars : [
		'stream',
		'fileName'
	],
	#category : #'Comix-Tools'
}

{ #category : #latex }
CXAbstractLaTeXPrinter >> columns [
	
	^ ''
]

{ #category : #initialization }
CXAbstractLaTeXPrinter >> defaultFileName [

	^ 'ShouldProvide'
]

{ #category : #latex }
CXAbstractLaTeXPrinter >> emitHLine [
	stream
		nextPutAll: '\\ \hline';
		cr
]

{ #category : #latex }
CXAbstractLaTeXPrinter >> emitLatexEnd [

	stream nextPutAll: '\end{document}'
]

{ #category : #latex }
CXAbstractLaTeXPrinter >> emitLatexStart [

	stream nextPutAll: '\documentclass[', self columns, ']{article}
\usepackage[utf8]{inputenc}  %% les accents dans le fichier.tex
\usepackage{calc}
\usepackage[pdftex]{graphicx}
\usepackage{vmargin}
\setmarginsrb{1.2cm}{2cm}{1.2cm}{1.2cm}{0cm}{0cm}{0cm}{0cm}
\pagestyle{empty}
\begin{document}
\noindent
\scriptsize'
]

{ #category : #latex }
CXAbstractLaTeXPrinter >> emitSeparator [
	stream nextPutAll: '&'
]

{ #category : #latex }
CXAbstractLaTeXPrinter >> emitTableEnd [

	stream cr ; nextPutAll: '\end{tabular}' ; cr
]

{ #category : #latex }
CXAbstractLaTeXPrinter >> extension [

	^ 'tex'
]

{ #category : #initialization }
CXAbstractLaTeXPrinter >> fileName [
	^ fileName ifNil: [ self defaultFileName ]
	
]

{ #category : #accessing }
CXAbstractLaTeXPrinter >> fileName: name [

	fileName := name
]

{ #category : #initialization }
CXAbstractLaTeXPrinter >> initialize [

	super initialize.
	self setStream
]

{ #category : #initialization }
CXAbstractLaTeXPrinter >> save [

	self emitLatexStart.
	self visitBase.
	self emitLatexEnd.
	stream flush
]

{ #category : #initialization }
CXAbstractLaTeXPrinter >> setStream [ 
	
	stream := (FileSystem workingDirectory nextNameFor: self fileName extension: self extension) asFileReference writeStream.
]
