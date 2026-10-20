Class {
	#name : 'CBWantedListTest',
	#superclass : 'TestCase',
	#instVars : [
		'list'
	],
	#category : 'CBComix-Tests',
	#package : 'CBComix-Tests'
}

{ #category : 'running' }
CBWantedListTest >> setUp [

	super setUp.
	list := CBWantedList new
]

{ #category : 'tests' }
CBWantedListTest >> testAddAndRemove [

	| wanted |
	self assert: list isEmpty.
	wanted := list add: (CBWantedAlbum seriesName: 'Gaston' number: 10).
	list add: wanted.
	self assert: list size equals: 1.
	self assert: (list includes: wanted).
	list remove: wanted.
	self assert: list isEmpty.
	list remove: wanted.
	self assert: list isEmpty
]

{ #category : 'tests' }
CBWantedListTest >> testDoAndEntriesCopy [

	| seen |
	list add: (CBWantedAlbum seriesName: 'Gaston' number: 10).
	list entries removeAll.
	seen := OrderedCollection new.
	list do: [ :each | seen add: each ].
	self assert: seen size equals: 1
]

{ #category : 'tests' }
CBWantedListTest >> testEntriesForSeriesNamed [

	| gaston |
	gaston := list add: (CBWantedAlbum seriesName: 'Gaston' number: 10).
	list add: (CBWantedAlbum seriesName: 'Spirou' number: 2).
	self assert: (list entriesForSeriesNamed: 'gaston') asArray equals: { gaston }
]
