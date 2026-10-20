Class {
	#name : 'CBLibraryTest',
	#superclass : 'TestCase',
	#instVars : [
		'library'
	],
	#category : 'CBComix-Tests',
	#package : 'CBComix-Tests'
}

{ #category : 'running' }
CBLibraryTest >> setUp [

	super setUp.
	library := CBLibrary new
]

{ #category : 'tests' }
CBLibraryTest >> testAcquire [

	| wanted album |
	library addAlbum: (CBAlbum new
			 series: (library seriesNamed: 'Gaston');
			 number: 9;
			 entryNumber: 41;
			 yourself).
	wanted := library addWanted: ((CBWantedAlbum seriesName: 'gaston' number: 10)
			           title: 'Le cas Lagaffe';
			           notes: 'first edition';
			           yourself).
	album := library acquire: wanted.
	self assert: library wanted isEmpty.
	self assert: (library owns: album).
	self assert: album series identicalTo: (library seriesNamed: 'Gaston').
	self assert: (album series albums includes: album).
	self assert: album number equals: 10.
	self assert: album title equals: 'Le cas Lagaffe'.
	self assert: album notes equals: 'first edition'.
	self assert: album publisher isUnknown.
	self assert: album entryNumber equals: 42
]

{ #category : 'tests' }
CBLibraryTest >> testAddAlbumRegistersInSeries [

	| album |
	album := library addAlbum: (CBAlbum new
			          series: (library seriesNamed: 'Gaston');
			          yourself).
	self assert: (library owns: album).
	self assert: ((library seriesNamed: 'Gaston') albums includes: album)
]

{ #category : 'tests' }
CBLibraryTest >> testAddProjection [

	| projection |
	projection := library addProjection: (library owned projectionNamed: 'recent' rule: [ :each | each year > 2020 ]).
	self assert: (library projectionNamed: 'recent') identicalTo: projection
]

{ #category : 'tests' }
CBLibraryTest >> testAllTags [

	(library seriesNamed: 'Gaston') addTag: #belgian.
	(library seriesNamed: 'Spirou')
		addTag: #belgian;
		addTag: #humor.
	self assert: library allTags equals: #( #belgian #humor ) asSet
]

{ #category : 'tests' }
CBLibraryTest >> testCurrent [

	self assert: (CBLibrary current isMemberOf: CBLibrary)
]

{ #category : 'tests' }
CBLibraryTest >> testHasSeriesNamed [

	self deny: (library hasSeriesNamed: 'Gaston').
	library seriesNamed: 'Gaston'.
	self assert: (library hasSeriesNamed: 'GASTON')
]

{ #category : 'tests' }
CBLibraryTest >> testNextEntryNumber [

	self assert: library nextEntryNumber equals: 1.
	library addAlbum: (CBAlbum new
			 series: (library seriesNamed: 'Gaston');
			 entryNumber: 7;
			 yourself).
	self assert: library nextEntryNumber equals: 8
]

{ #category : 'tests' }
CBLibraryTest >> testNormalize [

	self assert: (CBLibrary normalize: '  Gaston ') equals: 'gaston'
]

{ #category : 'tests' }
CBLibraryTest >> testRebuildProjectionsCreatesOnePerTag [

	| gaston watchmen |
	(library seriesNamed: 'Gaston')
		addTag: #belgian;
		addTag: #humor.
	(library seriesNamed: 'Watchmen') addTag: #usa.
	gaston := library addAlbum: (CBAlbum new
			           series: (library seriesNamed: 'Gaston');
			           yourself).
	watchmen := library addAlbum: (CBAlbum new
			             series: (library seriesNamed: 'Watchmen');
			             yourself).
	library rebuildProjections.
	self assert: library projections keys asSet equals: #( #belgian #humor #usa ) asSet.
	self assert: (library projectionNamed: 'usa') albums asArray equals: { watchmen }.
	self assert: (library projectionNamed: #belgian) albums asArray equals: { gaston }.
	self assert: (library projectionNamed: #usa) source identicalTo: library owned
]

{ #category : 'tests' }
CBLibraryTest >> testRegistriesAreUniqueByNormalizedName [

	self assert: (library seriesNamed: 'Gaston') identicalTo: (library seriesNamed: ' gaston ').
	self assert: (library authorNamed: 'Franquin') identicalTo: (library authorNamed: 'FRANQUIN').
	self assert: (library publisherNamed: 'Dupuis') identicalTo: (library publisherNamed: 'dupuis ').
	self assert: (library seriesNamed: ' gaston ') name equals: 'Gaston'.
	self assert: library allSeries size equals: 1.
	self assert: library allAuthors size equals: 1.
	self assert: library allPublishers size equals: 1
]

{ #category : 'tests' }
CBLibraryTest >> testRemoveAlbumUnregistersFromSeries [

	| album |
	album := library addAlbum: (CBAlbum new
			          series: (library seriesNamed: 'Gaston');
			          yourself).
	library removeAlbum: album.
	self deny: (library owns: album).
	self assert: (library seriesNamed: 'Gaston') albums isEmpty
]

{ #category : 'tests' }
CBLibraryTest >> testSTONDoesNotSaveProjections [

	| contents |
	(library seriesNamed: 'Gaston') addTag: #belgian.
	library rebuildProjections.
	contents := STON toString: library.
	self deny: (contents includesSubstring: 'CBProjection')
]

{ #category : 'tests' }
CBLibraryTest >> testSTONRoundTrip [

	| file loaded gaston nine |
	(library seriesNamed: 'Gaston') addTag: #belgian.
	nine := library addAlbum: (CBAlbum new
			         series: (library seriesNamed: 'Gaston');
			         publisher: (library publisherNamed: 'Dupuis');
			         number: 9;
			         yourself).
	nine addAuthor: (library authorNamed: 'Franquin').
	library addAlbum: (CBAlbum new
			 series: (library seriesNamed: 'Gaston');
			 publisher: (library publisherNamed: 'Dupuis');
			 number: 10;
			 yourself).
	library addWanted: (CBWantedAlbum seriesName: 'Gaston' number: 11).
	library rebuildProjections.
	file := FileSystem memory root / 'library.ston'.
	library exportSTONTo: file.
	loaded := CBLibrary fromSTONFile: file.
	gaston := loaded seriesNamed: 'Gaston'.
	self assert: loaded owned size equals: 2.
	self assert: loaded wanted size equals: 1.
	self assert: gaston albums size equals: 2.
	self assert: (loaded owned albums allSatisfy: [ :each | each series == gaston ]).
	self assert: loaded owned albums first publisher identicalTo: (loaded publisherNamed: 'Dupuis').
	self assert: loaded owned albums first authors first identicalTo: (loaded authorNamed: 'Franquin').
	self assert: (loaded projectionNamed: #belgian) size equals: 2
]

{ #category : 'tests' }
CBLibraryTest >> testUnknownPublisher [

	self assert: library unknownPublisher isUnknown.
	self assert: library unknownPublisher identicalTo: library unknownPublisher
]

{ #category : 'tests' }
CBLibraryTest >> testWantedIsIndependentFromOwned [

	library addWanted: (CBWantedAlbum seriesName: 'Gaston' number: 10).
	self assert: library wanted size equals: 1.
	self assert: library owned isEmpty.
	self deny: (library hasSeriesNamed: 'Gaston')
]

{ #category : 'tests' }
CBLibraryTest >> testXMLRoundTrip [

	| file loaded |
	(library seriesNamed: 'Gaston') addTag: #belgian.
	library addAlbum: (CBAlbum new
			 series: (library seriesNamed: 'Gaston');
			 number: 9;
			 yourself).
	library addWanted: (CBWantedAlbum seriesName: 'Gaston' number: 10).
	file := FileSystem memory root / 'library.xml'.
	library exportXMLTo: file.
	loaded := CBLibrary fromXMLFile: file.
	self assert: loaded owned size equals: 1.
	self assert: loaded wanted size equals: 1.
	self assert: ((loaded seriesNamed: 'Gaston') hasTag: #belgian).
	self assert: (loaded projectionNamed: #belgian) size equals: 1
]
