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
