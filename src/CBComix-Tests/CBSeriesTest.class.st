Class {
	#name : 'CBSeriesTest',
	#superclass : 'TestCase',
	#instVars : [
		'series'
	],
	#category : 'CBComix-Tests',
	#package : 'CBComix-Tests'
}

{ #category : 'running' }
CBSeriesTest >> setUp [

	super setUp.
	series := CBSeries named: 'Gaston'
]

{ #category : 'tests' }
CBSeriesTest >> testAddAlbumOnlyOnce [

	| album |
	album := CBAlbum new.
	series addAlbum: album.
	series addAlbum: album.
	self assert: series albums size equals: 1
]

{ #category : 'tests' }
CBSeriesTest >> testAlbumsIsACopy [

	series albums add: CBAlbum new.
	self assert: series albums isEmpty
]

{ #category : 'tests' }
CBSeriesTest >> testDefaults [

	self assert: series name equals: 'Gaston'.
	self deny: series isComplete.
	self assert: series tags isEmpty.
	self assert: series albums isEmpty
]

{ #category : 'tests' }
CBSeriesTest >> testIsComplete [

	series isComplete: true.
	self assert: series isComplete
]

{ #category : 'tests' }
CBSeriesTest >> testIsOneShot [

	self deny: series isOneShot.
	series addAlbum: CBAlbum new.
	self assert: series isOneShot.
	series addAlbum: CBAlbum new.
	self deny: series isOneShot
]

{ #category : 'tests' }
CBSeriesTest >> testRemoveAlbum [

	| album |
	album := series addAlbum: CBAlbum new.
	series removeAlbum: album.
	self assert: series albums isEmpty.
	series removeAlbum: album.
	self assert: series albums isEmpty
]

{ #category : 'tests' }
CBSeriesTest >> testSortedAlbums [

	| ten nine |
	ten := series addAlbum: (CBAlbum new
			        number: 10;
			        yourself).
	nine := series addAlbum: (CBAlbum new
			         number: 9;
			         yourself).
	self assert: series sortedAlbums equals: {
			nine.
			ten }
]

{ #category : 'tests' }
CBSeriesTest >> testTags [

	series addTag: #belgian.
	series addTag: 'humor'.
	self assert: (series hasTag: #belgian).
	self assert: (series hasTag: #humor).
	series removeTag: #belgian.
	self deny: (series hasTag: #belgian).
	self assert: series tags asArray equals: #( #humor )
]
