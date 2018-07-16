Class {
	#name : #CXBase,
	#superclass : #Object,
	#instVars : [
		'bds',
		'workingDirectory'
	],
	#category : #'Comix-Model'
}

{ #category : #adding }
CXBase >> add: aBD [

	bds add: aBD 
]

{ #category : #adding }
CXBase >> addSerie: aSerie [

	bds at: aSerie sortedAs put: aSerie 
]

{ #category : #accessing }
CXBase >> bds [

	^ bds
]

{ #category : #initialize }
CXBase >> initialize [

	super initialize.
	bds := OrderedCollection new. 
	workingDirectory := FileSystem workingDirectory.
]

{ #category : #io }
CXBase >> load [
	"self new load"
	| base |
	
	base := (workingDirectory lastFileFor: 'BDs' extension: 'ston') 
		asFileReference readStreamDo: [ :str | (STON fromStream: str)].
	^ base
]

{ #category : #io }
CXBase >> save [

	(workingDirectory / (workingDirectory nextNameFor: 'BDs' extension: 'ston')) 
		asFileReference writeStreamDo: [ :str | str nextPutAll: 
		(STON toStringPretty: self)]
]
