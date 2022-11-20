"
I manage multiple bases (group of series) in a generic manner.  
I'm a singleton since I manage the bases. 

```
	| ownedBaseFromXML ownedBaseFromSTON collector |
	ownedBaseFromXML := CXBase new addNewSerieFromCollection: CXXMLImporter new import.
	ownedBaseFromXML kind: #xml.
	ownedBaseFromSTON := CXBase load: 'BDs'.
	ownedBaseFromSTON kind: #ston.
	ownedBaseFromSTON numberOfBDs . 
	ownedBaseFromXML numberOfBDs.
	
	collector := CXCollector new.
	collector add: ownedBaseFromXML.
	collector save.
```	

```	
	| lookingForBase serie |
	serie := (CXSerie new sortedAs: 'Empress' ; title: 'Empress').
	lookingForBase := (CXBase new addSerie: serie).
	lookingForBase kind: #lookingFor.
	lookingForBase saveKind
```

"
Class {
	#name : #CXCollector,
	#superclass : #Object,
	#instVars : [
		'bases',
		'fileName'
	],
	#classInstVars : [
		'uniqueInstance',
		'workingDirectory'
	],
	#category : #'Comix-Model'
}

{ #category : #'save/load' }
CXCollector class >> defaultFileName [

	^ 'CXCollection'
]

{ #category : #loading }
CXCollector class >> install [
	"self install"

	self setUniqueInstance: (self install: self defaultFileName)
]

{ #category : #loading }
CXCollector class >> install: filename [
	"self install: 'CXCollection'"

	self setUniqueInstance: (self install: filename)
]

{ #category : #loading }
CXCollector class >> load [
	"self load"

	^ self load: self defaultFileName
]

{ #category : #loading }
CXCollector class >> load: filename [
	"self load: 'CXCollection'"

	| instance |
	instance := (self workingDirectory lastFileFor: filename extension: 'ston')
		asFileReference readStreamDo: [ :str | STON fromStream: str ].
	^ instance
]

{ #category : #accessing }
CXCollector class >> setUniqueInstance: anInstance [

	uniqueInstance := anInstance
]

{ #category : #accessing }
CXCollector class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'save/load' }
CXCollector class >> workingDirectory [

	^ workingDirectory ifNil: [ workingDirectory := FileSystem workingDirectory ]
]

{ #category : #'save/load' }
CXCollector class >> workingDirectory: aFileReference [
	workingDirectory := aFileReference
]

{ #category : #'adding/removing' }
CXCollector >> add: aCXBase [
	
	bases at: aCXBase kind put: aCXBase
]

{ #category : #accessing }
CXCollector >> baseFor: aString [
	^ bases at: aString asSymbol ifAbsent: [ self error: 'base ' , aString , '  not found' ]
]

{ #category : #accessing }
CXCollector >> baseNames [
	^ bases keys
]

{ #category : #'save/load' }
CXCollector >> fileName [
	^ fileName ifNil: [ fileName := self class defaultFileName ]
]

{ #category : #'save/load' }
CXCollector >> fileName: aString [
	fileName := aString
]

{ #category : #initialization }
CXCollector >> initialize [
	super initialize.
	bases := Dictionary new.

]

{ #category : #'adding/removing' }
CXCollector >> remove: aSymbol [

	bases removeKey: aSymbol ifAbsent: [ ]
]

{ #category : #'save/load' }
CXCollector >> save [
	(self workingDirectory / (self workingDirectory nextNameFor: self fileName extension: 'ston'))
		asFileReference writeStreamDo: [ :str | str nextPutAll: (STON toStringPretty: self) ]
]

{ #category : #'save/load' }
CXCollector >> workingDirectory [
	^ self class workingDirectory
]
