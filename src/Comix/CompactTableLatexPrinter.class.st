"
CompactTableLatexPrinter new
	setBase: (CXBase new addNewSerieFromCollection: (STON fromStream: 'BDs.1.ston' asFileReference readStream))
	save.
	
	
CompactTableLatexPrinter new
	setBase: (CXBase new addNewSerieFromCollection: CXXMLImporter import);
	save.
		
CXXMLImporter import
"
Class {
	#name : #CompactTableLatexPrinter,
	#superclass : #CXTools,
	#instVars : [
		'stream',
		'twoColumn',
		'lines',
		'fileName'
	],
	#category : #'Comix-Tools'
}

{ #category : #latex }
CompactTableLatexPrinter >> columns [
	
	^ ''
]

{ #category : #initialization }
CompactTableLatexPrinter >> defaultFileName [
	^ fileName ifNil: [ 'BELIST' ]
	
]

{ #category : #operate }
CompactTableLatexPrinter >> dispatchInColumns [
	| bds totalSize size |
	"the logic looks strange but we need to know the size of a serie for paginating
	the items. Therefore we use the series."
	bds := base bdsSortedBySeries.
	totalSize := bds size.
	totalSize odd
		ifTrue: [ size := totalSize - 1 ]
		ifFalse: [ size := totalSize ].
	1 to: size by: 2 do: [ :i | 
		self printBD: (bds at: i).
		self emitSeparator.
		self printBD: (bds at: i + 1).
		self emitHLine.
		(i + 1 rem: 120) isZero
			ifTrue: [ self emitTableEnd.
				self emitTableStart ] ].
	self printBD: (bds at: totalSize).

	"to finish the latex?"
	self
		printBD:
			(CXItem new
				title: ' ';
				original: false;
				serie: ' ';
				number: 0;
				year: 0)
]

{ #category : #latex }
CompactTableLatexPrinter >> emitHLine [
	stream
		nextPutAll: '\\ \hline';
		cr
]

{ #category : #latex }
CompactTableLatexPrinter >> emitLatexEnd [

	stream nextPutAll: '\end{document}'
]

{ #category : #latex }
CompactTableLatexPrinter >> emitLatexStart [

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
CompactTableLatexPrinter >> emitSeparator [
	stream nextPutAll: '&'
]

{ #category : #latex }
CompactTableLatexPrinter >> emitTableEnd [

	stream cr ; nextPutAll: '\end{tabular}' ; cr
]

{ #category : #latex }
CompactTableLatexPrinter >> emitTableStart [

	stream cr ; 
		nextPutAll: '\noindent\begin{tabular}{|p{0.3cm}p{3.2cm}p{3cm}p{0.5cm}||p{0.3cm}p{3.2cm}p{3cm}p{0.5cm}|}\hline' ; cr

]

{ #category : #latex }
CompactTableLatexPrinter >> extension [

	^ 'tex'
]

{ #category : #accessing }
CompactTableLatexPrinter >> fileName: name [

	fileName := name
]

{ #category : #initialization }
CompactTableLatexPrinter >> initialize [

	super initialize.
	lines := 0.
	self fileName: 'BELIST'.
	twoColumn := true.
	self setStream
]

{ #category : #latex }
CompactTableLatexPrinter >> linePlus [

	lines := lines + 1 

]

{ #category : #latex }
CompactTableLatexPrinter >> printBD: aBD [
	
	aBD original 
		ifTrue: [
			stream cr.
		
			aBD isSpeciallyNumbered
				 ifTrue: [ stream 
								nextPutAll: aBD publicNumber asString ;  
								nextPutAll: '/' ; 
								nextPutAll: aBD sortedAs asString] 
				ifFalse: [ stream 
								nextPutAll: aBD publicNumber asString ].
			self emitSeparator. 	
			stream 	
				nextPutAll: aBD serie asString.
			self emitSeparator. 	
			stream  
				nextPutAll: aBD title asString.
			self emitSeparator. 	
			stream 
				nextPutAll: aBD year asString ]
]

{ #category : #actions }
CompactTableLatexPrinter >> save [

	self emitLatexStart.
	self treatBase.
	self emitLatexEnd.
	stream flush
]

{ #category : #initialization }
CompactTableLatexPrinter >> setStream [ 
	
	stream := "FileSystem workingDirectory lastFileFor: self defaultFileName extension: self extension"
	(FileSystem workingDirectory nextNameFor: self defaultFileName extension: self extension) asFileReference writeStream.
]

{ #category : #operate }
CompactTableLatexPrinter >> treatBase [

	self emitTableStart.
	self dispatchInColumns.
	self emitTableEnd
]

{ #category : #actions }
CompactTableLatexPrinter >> visitBase [
	"We redefine the tranversal because we fill the table item by items"
	self save
	
]

{ #category : #latex }
CompactTableLatexPrinter >> visitItem: aBD [
	
	self printBD: aBD
]
