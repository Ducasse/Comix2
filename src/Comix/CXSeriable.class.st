Class {
	#name : #CXSeriable,
	#superclass : #Object,
	#instVars : [
		'title',
		'sortedAs',
		'serieComplete',
		'bds'
	],
	#category : #'Comix-Model'
}

{ #category : #accessing }
CXSeriable >> bds [ 

	^ bds
]

{ #category : #accessing }
CXSeriable >> bds: aCol [

	bds := aCol.
	self checkValidity.
]

{ #category : #accessing }
CXSeriable >> checkValidity [
	
	bds allSatisfy: [ :each | each serie = self title ]
]

{ #category : #initialization }
CXSeriable >> initialize [

	super initialize.
	serieComplete := false.
	
]

{ #category : #testing }
CXSeriable >> isSerieComplete [

	^ serieComplete isNil 
		ifTrue: [ false ]
		ifFalse: [ serieComplete ]
]

{ #category : #queries }
CXSeriable >> maxNumber [

	| max |
	max := 0.
	bds do: [:each | each number ifNotNil: [max := each number max: max]].
	^ max 
]

{ #category : #printing }
CXSeriable >> printOn: aStream [

	super printOn: aStream. 
	aStream << title
]

{ #category : #accessing }
CXSeriable >> serieComplete: aBoolean [

	serieComplete := aBoolean.
]

{ #category : #accessing }
CXSeriable >> sortedAs [

	^ sortedAs ifNil: [ title ]
]

{ #category : #accessing }
CXSeriable >> sortedAs: aString [

	sortedAs := aString
]

{ #category : #accessing }
CXSeriable >> title [ 

	^ title
]

{ #category : #accessing }
CXSeriable >> title: aString [

	title := aString
]
