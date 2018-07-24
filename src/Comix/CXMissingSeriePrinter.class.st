"
CXMissingSeriePrinter new
	setBase: (CXBase new addNewSerieFromCollection: CXXMLImporter import);
	save.
"
Class {
	#name : #CXMissingSeriePrinter,
	#superclass : #CXAbstractLaTeXPrinter,
	#category : #'Comix-Tools'
}

{ #category : #initialization }
CXMissingSeriePrinter >> columns [

	^ 'twocolumn'
]

{ #category : #initialization }
CXMissingSeriePrinter >> defaultFileName [

	^ 'MissingSeries'
]

{ #category : #initialization }
CXMissingSeriePrinter >> visitSerie: aSerie [

	aSerie missingNumbers first isEmpty
		ifFalse: [
			stream 
				nextPutAll: '\paragraph{';
				nextPutAll: aSerie title asString;
				nextPutAll: ' (Ms:';
				nextPutAll: aSerie missingNumberString.
			stream 
				nextPutAll: ')' ; 
				nextPutAll: '} '.
			stream cr ]
]
