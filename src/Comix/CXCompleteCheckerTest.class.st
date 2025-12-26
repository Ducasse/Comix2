Class {
	#name : 'CXCompleteCheckerTest',
	#superclass : 'CXBaseTest',
	#instVars : [
		'checker'
	],
	#category : 'Comix-Tests',
	#package : 'Comix',
	#tag : 'Tests'
}

{ #category : 'setup' }
CXCompleteCheckerTest >> setUp [
	super setUp. 
	base := CXBase new addNewSerieFromCollection: (STON fromString: self stonFile contents).
	checker := CXCompleteChecker new setBase: base.
	

	
	
]

{ #category : 'tests' }
CXCompleteCheckerTest >> testACompleteSerieElementShouldBeSerieComplete [
	
	| aquablue aya |
	aquablue := base serieNamed: 'Aquablue'.
	checker visitSerie: aquablue.
	self assert: checker suspects size equals: 0.
	
	"we set the serie to complete but this is not true."
	aya := base serieNamed: 'Aya de Yopougon'.
	aya serieComplete: true. 
	checker visitSerie: aya. 
	self assert: checker suspects size equals: 1.
	"there is one bd stating that the serie is uncomplete"
]
