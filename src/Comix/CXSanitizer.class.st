Class {
	#name : #CXSanitizer,
	#superclass : #CXTools,
	#instVars : [
		'suspects'
	],
	#category : #'Comix-Tools'
}

{ #category : #operations }
CXSanitizer >> checkBase [

	base seriesDo: [ :aSerie | self checkSerie: aSerie ]
]

{ #category : #operations }
CXSanitizer >> checkSerie: aSerie [
	self subclassResponsibility 
]

{ #category : #initialization }
CXSanitizer >> initialize [
	super initialize.
	suspects := OrderedCollection new.
]

{ #category : #checks }
CXSanitizer >> log: aSerie [

	suspects add: aSerie. 
]

{ #category : #checks }
CXSanitizer >> suspects [

	^ suspects 
]
