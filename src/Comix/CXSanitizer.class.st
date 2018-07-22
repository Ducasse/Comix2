Class {
	#name : #CXSanitizer,
	#superclass : #CXTools,
	#instVars : [
		'suspects'
	],
	#category : #'Comix-Tools'
}

{ #category : #initialization }
CXSanitizer >> initialize [
	super initialize.
	suspects := OrderedCollection new.
]

{ #category : #operations }
CXSanitizer >> log: aSerie [

	suspects add: aSerie
]

{ #category : #accessing }
CXSanitizer >> suspects [

	^ suspects 
]

{ #category : #visiting }
CXSanitizer >> visitBase [

	base seriesDo: [ :aSerie | self visitSerie: aSerie ]
]
