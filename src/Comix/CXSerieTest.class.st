Class {
	#name : 'CXSerieTest',
	#superclass : 'TestCase',
	#category : 'Comix-Tests',
	#package : 'Comix',
	#tag : 'Tests'
}

{ #category : 'tests' }
CXSerieTest >> testAllBdsOfTheSeries [

	| serie |
	serie := CXItem nic serie.
	self assert: serie numberOfBDs equals: 2.
	serie bds do: [ :each | self assert: each serie equals: serie ].
]

{ #category : 'tests' }
CXSerieTest >> testMissingNumbers [ 
	
	| serie |
	serie := CXItem nic serie.
	self assert: serie missingNumbers first equals: #(3)
]

{ #category : 'tests' }
CXSerieTest >> testMissingNumbersWhenComplexSerie [
	
	| serie |
	serie := CXSerie potro.
	self assert: serie missingNumbers first equals: #(6)
	"it is difficult because this series is ranked
	1 -99
	2 -98 
	3 -97
	4 -84
	5 -83
	"
	"this is correct that so far the 6th is missing."
	
]
