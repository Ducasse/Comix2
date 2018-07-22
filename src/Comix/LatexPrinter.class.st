"
LatexPrinter new
	setBase: (CXBase new addNewSerieFromCollection: (STON fromString: CXBasicBaseTest contentsForTest));
	treatBase
	
"
Class {
	#name : #LatexPrinter,
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
LatexPrinter >> addLatexEnd [

	stream nextPutAll: '\end{document}'
]

{ #category : #latex }
LatexPrinter >> addLatexStart [

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
LatexPrinter >> addTableEnd [

	stream cr ; nextPutAll: '\end{tabular}' ; cr
]

{ #category : #latex }
LatexPrinter >> addTableStart [

	stream cr ; nextPutAll: '\noindent\begin{tabular}{|rp{3.2cm}p{4cm}r|}\hline' ; cr
]

{ #category : #latex }
LatexPrinter >> addTableTwoEnd [

	stream cr ; nextPutAll: '\end{tabular}' ; cr
]

{ #category : #latex }
LatexPrinter >> addTableTwoStart [

	stream cr ; nextPutAll: '\noindent\begin{tabular}{|p{0.5cm}p{3.2cm}p{3cm}p{0.5cm}||p{0.5cm}p{3.2cm}p{3cm}p{0.5cm}|}\hline' ; cr

]

{ #category : #latex }
LatexPrinter >> columns [
	
	^ ''
]

{ #category : #initialization }
LatexPrinter >> defaultFileName [
	^ fileName ifNil: [ 'BELIST' ]
	
]

{ #category : #operate }
LatexPrinter >> dispatch [
	
	| bds |
	bds := base bdsSortedBySeries.
	1 to: bds size do: [:i |
					self printBD: (bds at: i). self hline.
					(i rem: 84) isZero ifTrue: [ self addTableEnd. self addTableStart]].


]

{ #category : #operate }
LatexPrinter >> dispatchTwoColumns [

	| bds totalSize size |
	"the logic looks strange but we need to know the size of a serie for paginating
	the items. Therefore we use the series."
	
	bds := base bdsSortedBySeries.
	totalSize := bds size.
	totalSize odd ifTrue: [size := totalSize - 1] ifFalse: [size := totalSize].
	
	1 to: size
		by: 2
		do: 
			[:i | 
			self printBD: (bds at: i).
			stream nextPutAll: '&'.
			self printBD: (bds at: i + 1).
			self hline.
			(i + 1 rem: 120) isZero 
				ifTrue: 
					[self addTableTwoEnd.
					self addTableTwoStart]].
	self printBD: (bds at: totalSize).
	self printBD: ((CXItem new)
				title: ' ';
				original: false;
				serie: ' ';
				number: 0;
				year: 0)
]

{ #category : #latex }
LatexPrinter >> extension [

	^ 'tex'
]

{ #category : #accessing }
LatexPrinter >> fileName: name [

	fileName := name
]

{ #category : #latex }
LatexPrinter >> hline [
	stream
		nextPutAll: '\\ \hline';
		cr
]

{ #category : #initialization }
LatexPrinter >> initialize [

	super initialize.
	lines := 0.
	self fileName: 'BELIST'.
	twoColumn := true.
	self setStream
]

{ #category : #latex }
LatexPrinter >> linePlus [

	lines := lines + 1 

]

{ #category : #latex }
LatexPrinter >> printBD: aBD [

	aBD original 
		ifTrue: [
		stream cr; 
			nextPutAll: ((aBD hasNumber) ifTrue: [aBD publicNumber asString] ifFalse: ['']); nextPutAll: '&' ; 
			nextPutAll: aBD sortedAs asString ; nextPutAll: '&' ; 
			nextPutAll: aBD title asString ; nextPutAll: '&' ; 
			nextPutAll: aBD year asString ]
]

{ #category : #initialization }
LatexPrinter >> setStream [ 
	
	stream := "FileSystem workingDirectory lastFileFor: self defaultFileName extension: self extension"
	(FileSystem workingDirectory nextNameFor: self defaultFileName extension: self extension) asFileReference writeStream
]

{ #category : #initialization }
LatexPrinter >> stream [ 
	
	stream := FileSystem workingDirectory lastFileFor: self defaultFileName extension: self extension
]

{ #category : #operate }
LatexPrinter >> treatBase [

	twoColumn 
		ifTrue: 
			[ self addTableTwoStart.
			self dispatchTwoColumns.
			self addTableTwoEnd ]
		ifFalse: 
			[ self addTableStart.
			self dispatch.
			self addTableEnd ]
]
