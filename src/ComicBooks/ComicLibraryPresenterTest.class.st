Class {
	#name : 'ComicLibraryPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'library',
		'presenter',
		'tintin',
		'asterix'
	],
	#category : 'ComicBooks-Tests',
	#package : 'ComicBooks',
	#tag : 'Tests'
}

{ #category : 'testing support' }
ComicLibraryPresenterTest >> dialogForTest [ ^ self classProperty: #dialogForTest
]

{ #category : 'testing support' }
ComicLibraryPresenterTest >> dialogForTest: aDialog [ self classProperty: #dialogForTest put: aDialog
]

{ #category : 'running' }
ComicLibraryPresenterTest >> setUp [
	library := ComicLibrary new.

	tintin := ComicSeries name: 'Tintin'.
	tintin addChild: (ComicBook title: 'Le Lotus Bleu' author: 'Hergé' volumeNumber: 5).
	tintin addChild: (ComicBook title: 'Tintin au Tibet' author: 'Hergé' volumeNumber: 20).
	library addSeries: tintin.

	asterix := ComicSeries name: 'Astérix'.
	asterix addChild: (ComicBook title: 'Astérix le Gaulois' author: 'Goscinny & Uderzo' volumeNumber: 1).
	library addSeries: asterix.

	library addLooseBook: (ComicBook title: 'Le Chat' author: 'Geluck' volumeNumber: nil).

	presenter := ComicLibraryPresenter new.
	presenter library: library
]

{ #category : 'tests - model' }
ComicLibraryPresenterTest >> testAddChildToSeries [
	tintin addChild: (ComicBook title: 'L''Oreille cassée' author: 'Hergé' volumeNumber: 6).
	self assert: tintin children size equals: 3
]

{ #category : 'tests - library' }
ComicLibraryPresenterTest >> testAddLooseBookIncreasesLooseBooksCount [
	library addLooseBook: (ComicBook title: 'Gaston' author: 'Franquin' volumeNumber: nil).
	self assert: library looseBooks size equals: 2
]

{ #category : 'tests - library' }
ComicLibraryPresenterTest >> testAddSeriesIncreasesSeriesCount [
	library addSeries: (ComicSeries name: 'Lucky Luke').
	self assert: library series size equals: 3
]

{ #category : 'tests - model' }
ComicLibraryPresenterTest >> testBookChildrenIsEmpty [
	self assert: tintin children first children isEmpty
]

{ #category : 'tests - model' }
ComicLibraryPresenterTest >> testBookDisplayNameWithVolumeNumber [
	| book |
	book := ComicBook title: 'Le Lotus Bleu' author: 'Hergé' volumeNumber: 5.
	self assert: book displayName equals: '5. Le Lotus Bleu'
]

{ #category : 'tests - model' }
ComicLibraryPresenterTest >> testBookDisplayNameWithoutVolumeNumber [
	| book |
	book := ComicBook title: 'Le Chat' author: 'Geluck' volumeNumber: nil.
	self assert: book displayName equals: 'Le Chat'
]

{ #category : 'tests - model' }
ComicLibraryPresenterTest >> testBookIsLeaf [
	self assert: tintin children first isLeaf
]

{ #category : 'tests - presenter' }
ComicLibraryPresenterTest >> testClickAddBookWithNoSelectionAddsLooseBook [
	| initialCount |
	initialCount := library looseBooks size.

	SpWindowSimulateOpenModal
		value: [ :dialogWindow |
			dialogWindow presenter titleInput text: 'Gaston Lagaffe'.
			dialogWindow presenter authorInput text: 'Franquin'.
			dialogWindow triggerOkAction ]
		during: [ presenter addButton click ].

	self assert: library looseBooks size equals: initialCount + 1.
	self assert: library looseBooks last title equals: 'Gaston Lagaffe'.
	self assert: library looseBooks last author equals: 'Franquin'
]

{ #category : 'tests - library' }
ComicLibraryPresenterTest >> testLibraryHasOneLooseBook [
	self assert: library looseBooks size equals: 1
]

{ #category : 'tests - library' }
ComicLibraryPresenterTest >> testLibraryHasTwoSeries [
	self assert: library series size equals: 2
]

{ #category : 'tests - library' }
ComicLibraryPresenterTest >> testLibraryNodesContainsSeriesAndLooseBooks [
	self assert: library nodes size equals: 3
]

{ #category : 'tests - presenter' }
ComicLibraryPresenterTest >> testPresenterHasAddBookButton [
	self assert: presenter addButton label equals: 'Add book'
]

{ #category : 'tests - presenter' }
ComicLibraryPresenterTest >> testPresenterHasAddSeriesButton [
	self assert: presenter addSeriesButton label equals: 'Add series'
]

{ #category : 'tests - presenter' }
ComicLibraryPresenterTest >> testPresenterTreeRootsMatchLibraryNodes [
	self assert: presenter tree roots equals: library nodes
]

{ #category : 'tests - presenter' }
ComicLibraryPresenterTest >> testPresenterTreeRootsUpdateAfterAddingSeries [
	library addSeries: (ComicSeries name: 'Lucky Luke').
	presenter library: library.
	self assert: presenter tree roots size equals: 4
]

{ #category : 'tests - model' }
ComicLibraryPresenterTest >> testSeriesChildrenAreItsVolumes [
	self assert: tintin children size equals: 2
]

{ #category : 'tests - model' }
ComicLibraryPresenterTest >> testSeriesDisplayNameIsItsName [
	self assert: tintin displayName equals: 'Tintin'
]

{ #category : 'tests - model' }
ComicLibraryPresenterTest >> testSeriesIsNotLeaf [
	self deny: tintin isLeaf
]
