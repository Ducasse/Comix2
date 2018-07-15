Class {
	#name : #BDBase,
	#superclass : #Object,
	#instVars : [
		'bds',
		'workingDirectory'
	],
	#category : #Comix
}

{ #category : #adding }
BDBase >> add: aBD [

	bds add: aBD 
]

{ #category : #initialize }
BDBase >> initialize [

	super initialize.
	bds := OrderedCollection new. 
	workingDirectory := FileSystem workingDirectory.
]

{ #category : #io }
BDBase >> save [

	(workingDirectory / (workingDirectory nextNameFor: 'BDs' extension: 'ston')) 
		asFileReference writeStreamDo: [ :str | str nextPutAll: 
		(STON toStringPretty: self)]
]
