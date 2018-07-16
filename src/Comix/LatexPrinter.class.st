Class {
	#name : #LatexPrinter,
	#superclass : #CXTools,
	#instVars : [
		'stream',
		'twoColumn',
		'lines'
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

{ #category : #latex }
LatexPrinter >> dispatch [
	
	| bds |
	bds := base bdsSortedBySeries.
	1 to: bds size do: [:i |
					self printBD: (bds at: i). self hline.
					(i rem: 84) isZero ifTrue: [ self addTableEnd. self addTableStart]].


]

{ #category : #latex }
LatexPrinter >> dispatchTwoColumns [

	| bds totalSize size |
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
				serie: ' ';
				number: 0;
				year: 0)
]

{ #category : #latex }
LatexPrinter >> extension [

	^ 'tex'
]

{ #category : #latex }
LatexPrinter >> hline [
	stream
		nextPutAll: '\\ \hline';
		cr
]

{ #category : #latex }
LatexPrinter >> initialize [

	super initialize.
	lines := 0.
	self fileName: 'BELIST'.
	twoColumn := true.
]

{ #category : #latex }
LatexPrinter >> linePlus [

	lines := lines +1 

]

{ #category : #latex }
LatexPrinter >> printBD: aBD [

	aBD isOriginal 
		ifTrue: [
		stream cr; 
			nextPutAll: ((aBD hasNumber) ifTrue: [aBD publicNumber asString] ifFalse: ['']); nextPutAll: '&' ; 
			nextPutAll: aBD publicSortedAs asString ; nextPutAll: '&' ; 
			nextPutAll: aBD title asString ; nextPutAll: '&' ; 
			nextPutAll: aBD year asString ]
]

{ #category : #latex }
LatexPrinter >> self [ stream.
	self addLatexStart.
	self treatBase.
	self addLatexEnd
]

{ #category : #latex }
LatexPrinter >> stream [ 
	
	stream := (MultiByteFileStream newFileNamed: self nextBDFileName).
	stream converter: UTF8TextConverter new
]

{ #category : #latex }
LatexPrinter >> treatBase [

	twoColumn 
		ifTrue: 
			[self addTableTwoStart.
			self dispatchTwoColumns.
			self addTableTwoEnd]
		ifFalse: 
			[self addTableStart.
			self dispatch.
			self addTableEnd]
]