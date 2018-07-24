"
I manage multiple bases (group of series) in a generic manner.  
I'm a singleton since I manage the bases. 
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
CXCollector class >> load [
	"self new load"

	self load: self defaultFileName 
]

{ #category : #loading }
CXCollector class >> load: filename [
	"self new load"

	| base |
	base := (self workingDirectory lastFileFor: filename extension: 'ston')
		asFileReference readStreamDo: [ :str | STON fromStream: str ].
	uniqueInstance := base
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
