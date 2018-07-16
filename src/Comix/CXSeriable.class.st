"
Having a computed (by opposition to storing the information) version of a serie completeness is unclear,
since we can have two comix and still the serie is in 5 tomes and we do not know it and cannot deduce it. 
"
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

{ #category : #queries }
CXSeriable >> missingNumbers [

	| all strange max |
	strange := OrderedCollection new.
	max := self maxNumber.
	all := (1 to: max) asOrderedCollection.
	bds do: [:each | 
				each original ifTrue: [
					(all includes: each number) 
						ifTrue: [ all remove: each number]
						ifFalse: [ strange add: each number]]].
	"when the serie is not finished we make sure that we mention that the next one is missing."
	self isSerieComplete ifFalse: [all add: max + 1].
	^ {all asArray . strange asArray}
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
