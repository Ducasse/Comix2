Class {
	#name : #CXCompleteCheckerTest,
	#superclass : #CXBaseTest,
	#instVars : [
		'base',
		'checker'
	],
	#category : #'Comix-Model'
}

{ #category : #setup }
CXCompleteCheckerTest >> setUp [
	super setUp. 
	base := CXBase new addNewSerieFromCollection: (STON fromString: self stonFile contents).
	checker := CXCompleteChecker new setBase: base.
	

	
	
]

{ #category : #tests }
CXCompleteCheckerTest >> testACompleteSerieElementShouldBeSerieComplete [
	
	| aquablue |
	aquablue := (base serieNamed: 'Aquablue').
	checker checkSerie: aquablue.
	self assert: checker suspects size equals: 0.
	
	
]
