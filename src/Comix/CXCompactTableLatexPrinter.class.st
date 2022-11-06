"
```
CXCompactTableLatexPrinter new
	setBase: (CXBase new addNewSerieFromCollection: (STON fromStream: 'BDs.1.ston' asFileReference readStream))
	save.
```

With files taken in the working directory

```	
CXCompactTableLatexPrinter new
	setBase: (CXBase new addNewSerieFromCollection: CXXMLImporter new import);
	save.
```

With files taken from the git storage location.
```		
CXCompactTableLatexPrinter new
	setBase: (CXBase stefBase addNewSerieFromCollection: CXXMLImporter stefBds);
	setWorkingDirectoryFromBase;
	save.
```
"
Class {
	#name : #CXCompactTableLatexPrinter,
	#superclass : #CXAbstractLaTeXPrinter,
	#instVars : [
		'lines'
	],
	#category : #'Comix-Tools'
}

{ #category : #initialization }
CXCompactTableLatexPrinter >> defaultFileName [
	^ 'CompactFullList'
	
]

{ #category : #operate }
CXCompactTableLatexPrinter >> dispatchInColumns [
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
CXCompactTableLatexPrinter >> emitTableStart [

	stream cr ; 
		nextPutAll: '\noindent\begin{tabular}{p{0.3cm}p{3.2cm}p{3cm}p{0.5cm}|p{0.3cm}p{3.2cm}p{3cm}p{0.5cm}}\hline' ; cr

]

{ #category : #initialization }
CXCompactTableLatexPrinter >> initialize [

	super initialize.
	lines := 0.
	self fileName: 'BELIST'.

]

{ #category : #latex }
CXCompactTableLatexPrinter >> linePlus [

	lines := lines + 1 

]

{ #category : #latex }
CXCompactTableLatexPrinter >> printBD: aBD [
	
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
CXCompactTableLatexPrinter >> save [
	
	self setStream.
	self emitLatexStart.
	self treatBase.
	self emitLatexEnd.
	stream flush.
	stream close
]

{ #category : #operate }
CXCompactTableLatexPrinter >> treatBase [

	self emitTableStart.
	self dispatchInColumns.
	self emitTableEnd
]

{ #category : #actions }
CXCompactTableLatexPrinter >> visitBase [
	"We redefine the tranversal because we fill the table item by items"
	self save
	
]

{ #category : #latex }
CXCompactTableLatexPrinter >> visitItem: aBD [
	
	self printBD: aBD
]
