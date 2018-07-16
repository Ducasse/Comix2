"
Basic tests for the base. 
Tests relatives to tools (such as the checkers) are pushed down. 
"
Class {
	#name : #CXBaseTest,
	#superclass : #CXBasicBaseTest,
	#instVars : [
		'base'
	],
	#category : #'Comix-Model'
}

{ #category : #setup }
CXBaseTest >> setUp [

	super setUp.
	base := CXBase new.  
	base addNewSerieFromCollection: (STON fromString: self stonFile contents).
]

{ #category : #tests }
CXBaseTest >> testAddNewSerieFromCollection [
	"self new testAddNewSerieFromCollection"

	self assert: base series size equals: 3. 
]

{ #category : #tests }
CXBaseTest >> testBdsDo [
	"self new testBdsDo"
	
	| count |
	count := 0.
	base bdsDo: [ :serie | count := count + 1 ].
	self assert: count equals: 8
]

{ #category : #tests }
CXBaseTest >> testMaxNumber [
	"self new testMaxNumber"
	
	| oumok aquablue |
	oumok := (base serieNamed: 'Nic oumouk').
	self assert: oumok maxNumber equals: 1. 
	aquablue := (base serieNamed: 'Aquablue').
	self assert: aquablue maxNumber equals: 8. 
]

{ #category : #tests }
CXBaseTest >> testMissingNumbers [
	"self new testMissingNumbers"
	
	| oumok aquablue aya|
	oumok := (base serieNamed: 'Nic oumouk').
	self assert: oumok missingNumbers equals: #((2) #()). 
	aquablue := (base serieNamed: 'Aquablue').
	self assert: aquablue missingNumbers equals: #((1 4 5 7 9) #()).  
	"since the first one is not an original"
	aya := (base serieNamed: 'Aya de Yopougon').
	self assert: aya missingNumbers equals: #((1 3 5) #())  
]

{ #category : #tests }
CXBaseTest >> testSerieComplete [
	"self new testSerieNamed"
	
	| aquablue | 
	aquablue := (base serieNamed: 'Aquablue').
	aquablue serieComplete: true. 
	self assert: aquablue isSerieComplete.

]

{ #category : #tests }
CXBaseTest >> testSerieNamed [
	"self new testSerieNamed"
	
	| oumok aquablue |
	oumok := (base serieNamed: 'Nic oumouk').
	self assert: oumok bds size equals: 1. 
	aquablue := (base serieNamed: 'Aquablue').
	self assert: aquablue bds size equals: 5. 
]

{ #category : #tests }
CXBaseTest >> testSeriesDo [
	"self new testSeriesDo"

	| count |
	count := 0.
	base seriesDo: [ :serie | count := count + 1 ].
	self assert: count equals: 3
]
