"
For now manage original and not original. 
Once we have series connected and saved. 
We will be able to document better: complete or not.


CXSeriePrinter new
	setBase: (CXBase new addNewSerieFromCollection: CXXMLImporter import);
	save.
"
Class {
	#name : #CXSeriePrinter,
	#superclass : #CXAbstractLaTeXPrinter,
	#category : #'Comix-Tools'
}

{ #category : #latex }
CXSeriePrinter >> columns [

	^ 'twocolumn'
]

{ #category : #initialization }
CXSeriePrinter >> defaultFileName [

	^ 'Series'
]

{ #category : #operate }
CXSeriePrinter >> doBase [
	base seriesDo: [ :aSerie | 
		"aSerie title = 'Bretagne'
			ifTrue: [ self halt ]."
		(aSerie bds size = 1 and: [aSerie bds first original not ])
				ifFalse: [ self visitSerie: aSerie ]]
]

{ #category : #visiting }
CXSeriePrinter >> doSerie: aSerie [
	aSerie bdsDo: [ :each | self visitItem: each ]
]

{ #category : #operate }
CXSeriePrinter >> postSerie: aSerie [

	stream nextPutAll: '\end{itemize}'; cr
]

{ #category : #operate }
CXSeriePrinter >> preSerie: aSerie [

	stream nextPutAll: '\begin{itemize}'; cr
]

{ #category : #operate }
CXSeriePrinter >> visitItem: anItem [

	stream nextPutAll: '\item '.
	stream nextPutAll: anItem number printString. 
	stream space; nextPutAll: '-'.
	stream nextPutAll: anItem title asString. 
	stream space; nextPutAll: '-'.
	stream nextPutAll: anItem year printString. 
	stream space.
	stream nextPutAll: (anItem original ifTrue: [  ' (orig)' ] ifFalse: [ ' (not original)' ]). 
	stream cr.
	
]

{ #category : #operate }
CXSeriePrinter >> visitSerie: aSerie [

	stream space; cr.
	stream 
		<< '\paragraph{' ; 
		<< aSerie title asString ; 
		<< '} ';
		<< aSerie missingNumberString;
		cr.
	super visitSerie: aSerie.
]
