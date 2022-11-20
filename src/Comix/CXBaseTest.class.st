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
	#category : #'Comix-Tests'
}

{ #category : #tests }
CXBaseTest >> invariantMaxNumber: aBase [
	"self new testMaxNumber"
	
	| oumok aquablue |
	oumok := (aBase serieNamed: 'Nic oumouk').
	self assert: oumok maxNumber equals: 1. 
	aquablue := (aBase serieNamed: 'Aquablue').
	self assert: aquablue maxNumber equals: 8. 
]

{ #category : #tests }
CXBaseTest >> invariantMissingNumbers: aBase [
	"self new testMissingNumbers"
	
	| oumok aquablue aya|
	oumok := (aBase serieNamed: 'Nic oumouk').
	self assert: oumok missingNumbers equals: #((2) #()). 
	aquablue := (aBase serieNamed: 'Aquablue').
	self assert: aquablue missingNumbers equals: #((1 4 5 7 9) #()).  
	"since the first one is not an original"
	aya := (aBase serieNamed: 'Aya de Yopougon').
	self assert: aya missingNumbers equals: #((1 3 5) #())  
]

{ #category : #tests }
CXBaseTest >> invariantNumberOfAllBds: aBase [
	
	| count |
	count := 0.
	aBase bdsDo: [ :serie | count := count + 1 ].
	self assert: count equals: 8
	
]

{ #category : #tests }
CXBaseTest >> invariantNumberOfOriginalBDs: aBase [
	
	| count |
	count := 0.
	aBase originalBdsDo: [ :serie | count := count + 1 ].
	self assert: count equals: 7
]

{ #category : #tests }
CXBaseTest >> invariantNumberOfSeries: aBase [

	| count |
	count := 0.
	aBase seriesDo: [ :serie | count := count + 1 ].
	self assert: count equals: 3
]

{ #category : #tests }
CXBaseTest >> invariantSerieComplete: aSerie [
	"self new testSerieNamed"
	

	self deny: aSerie isSerieComplete.
	aSerie serieComplete: true. 
	self assert: aSerie isSerieComplete.

]

{ #category : #setup }
CXBaseTest >> setUp [

	super setUp.
	base := CXBase new.  
	base addNewSerieFromCollection: (STON fromString: self stonFile contents).
]

{ #category : #'tests - migration from XML to Ston' }
CXBaseTest >> testAddNewSerieFromCollection [
	"self new testAddNewSerieFromCollection"

	self assert: base series size equals: 3. 
]

{ #category : #tests }
CXBaseTest >> testBdsDoCountsNotOriginalBDs [
	
	self invariantNumberOfAllBds: base
]

{ #category : #tests }
CXBaseTest >> testMaxNumber [
	"self new testMaxNumber"
	
	self invariantMaxNumber: base
]

{ #category : #tests }
CXBaseTest >> testMissingNumbers [
	"self new testMissingNumbers"
	
	self invariantMissingNumbers: base
]

{ #category : #tests }
CXBaseTest >> testOriginalBdsDo [
	
	self invariantNumberOfOriginalBDs: base
]

{ #category : #'tests - store/restore' }
CXBaseTest >> testPrepareToBeStored [
	"self new testPrepareToBeStored"

	self assert: base series first bds class equals: SortedCollection. 
	base prepareModelToBeSaved.
	self assert: base series first bds class equals: OrderedCollection. 
]

{ #category : #'tests - store/restore' }
CXBaseTest >> testRestoreModel [
	"self new testRestoreModel"

	self assert: base series first bds class equals: SortedCollection. 
	base prepareModelToBeSaved.
	self assert: base series first bds class equals: OrderedCollection. 
	base restoreModel.
	self assert: base series first bds class equals: SortedCollection. 
]

{ #category : #'tests - save and load' }
CXBaseTest >> testSaveCreatesAFile [ 

	self deny: (testingWorkingDirectory / 'saved.ston') exists.
	base saveOnFileReference: testingWorkingDirectory / 'saved.ston'.
	self assert: (testingWorkingDirectory / 'saved.ston') exists.
	
	
	
]

{ #category : #'tests - save and load' }
CXBaseTest >> testSavedStonIsOk [

	| newBase |
	base saveOnFileReference: testingWorkingDirectory / 'saved.ston'.
	newBase := base loadFromFileReference: (testingWorkingDirectory / 'saved.ston').
	self invariantNumberOfOriginalBDs: newBase.  	
		
	self invariantSerieComplete: (newBase serieNamed: 'Aquablue').
	self invariantSerieComplete: (newBase serieNamed: 'Nic oumouk').
	self invariantNumberOfSeries: newBase.
	
	self invariantMaxNumber: newBase.
	self invariantMissingNumbers: newBase
	
	
	
	
]

{ #category : #tests }
CXBaseTest >> testSerieComplete [
	
	self invariantSerieComplete: (base serieNamed: 'Aquablue').
	self invariantSerieComplete: (base serieNamed: 'Nic oumouk').
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
CXBaseTest >> testSerieTitle [
	"self new testSerieTitle"
	
	| oumok |
	oumok := (base serieNamed: 'Nic oumouk').
	self assert: oumok bds first serieTitle equals: 'Nic oumouk'. 
	
]

{ #category : #tests }
CXBaseTest >> testSeriesDo [
	
	self invariantNumberOfSeries: base
]
