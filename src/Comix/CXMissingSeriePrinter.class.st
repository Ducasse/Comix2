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
	stream nextPutAll: '\paragraph{' , aSerie title asString.
	stream nextPutAll: ' (Ms:'.
	aSerie missingNumbers first do: [:missing | stream nextPutAll: missing asString] 
		separatedBy: [stream nextPut: Character space].
	stream nextPutAll: ')' ; nextPutAll: '}' ; cr]
]
