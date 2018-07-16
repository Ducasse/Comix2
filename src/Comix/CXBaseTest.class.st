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
	
	| base col count |
	base := CXBase new.  
	col := (STON fromString: self stonFile contents).
	base addNewSerieFromCollection: col.
	count := 0.
	base seriesDo: [ :serie | count := count + 1 ].
	self assert: count equals: 3
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
