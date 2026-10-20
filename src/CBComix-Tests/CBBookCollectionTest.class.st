Class {
	#name : 'CBBookCollectionTest',
	#superclass : 'TestCase',
	#instVars : [
		'collection',
		'gaston',
		'blake',
		'gaston9',
		'gaston10',
		'blake1'
	],
	#category : 'CBComix-Tests',
	#package : 'CBComix-Tests'
}

{ #category : 'running' }
CBBookCollectionTest >> setUp [

	super setUp.
	collection := CBBookCollection named: 'owned'.
	gaston := CBSeries named: 'Gaston'.
	gaston addTag: #belgian.
	blake := CBSeries named: 'Blake et Mortimer'.
	gaston9 := collection add: (CBAlbum new
			            series: gaston;
			            number: 9;
			            entryNumber: 2;
			            yourself).
	gaston10 := collection add: (CBAlbum new
			             series: gaston;
			             number: 10;
			             entryNumber: 3;
			             yourself).
	blake1 := collection add: (CBAlbum new
			           series: blake;
			           number: 1;
			           entryNumber: 1;
			           yourself)
]

{ #category : 'tests' }
CBBookCollectionTest >> testAddOnlyOnce [

	collection add: gaston9.
	self assert: collection size equals: 3
]

{ #category : 'tests' }
CBBookCollectionTest >> testAlbumsIsACopy [

	collection albums removeAll.
	self assert: collection size equals: 3
]

{ #category : 'tests' }
CBBookCollectionTest >> testAlbumsOfSeries [

	self assert: (collection albumsOfSeries: gaston) asArray equals: {
			gaston9.
			gaston10 }
]

{ #category : 'tests' }
CBBookCollectionTest >> testAlbumsSortedBy [

	self assert: (collection albumsSortedBy: [ :a :b | a entryNumber <= b entryNumber ]) equals: {
			blake1.
			gaston9.
			gaston10 }
]

{ #category : 'tests' }
CBBookCollectionTest >> testAlbumsWithTag [

	self assert: (collection albumsWithTag: #belgian) asArray equals: {
			gaston9.
			gaston10 }
]

{ #category : 'tests' }
CBBookCollectionTest >> testDetectIfNone [

	self assert: (collection detect: [ :each | each number = 10 ] ifNone: [ nil ]) equals: gaston10.
	self assert: (collection detect: [ :each | each number = 99 ] ifNone: [ #none ]) equals: #none
]

{ #category : 'tests' }
CBBookCollectionTest >> testDo [

	| seen |
	seen := OrderedCollection new.
	collection do: [ :each | seen add: each ].
	self assert: seen asArray equals: {
			gaston9.
			gaston10.
			blake1 }
]

{ #category : 'tests' }
CBBookCollectionTest >> testIsEmpty [

	self deny: collection isEmpty.
	self assert: CBBookCollection new isEmpty
]

{ #category : 'tests' }
CBBookCollectionTest >> testPrintOn [

	self assert: collection printString equals: 'owned (3 albums)'
]

{ #category : 'tests' }
CBBookCollectionTest >> testRemove [

	collection remove: gaston9.
	self deny: (collection includes: gaston9).
	self assert: collection size equals: 2.
	collection remove: gaston9.
	self assert: collection size equals: 2
]
