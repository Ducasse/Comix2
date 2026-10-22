Class {
	#name : 'CBXMLExporterTest',
	#superclass : 'TestCase',
	#instVars : [
		'library'
	],
	#category : 'CBComix-Tests-ImportExport',
	#package : 'CBComix-Tests',
	#tag : 'ImportExport'
}

{ #category : 'running' }
CBXMLExporterTest >> setUp [

	| album |
	super setUp.
	library := CBLibrary new.
	(library seriesNamed: 'XIII')
		addTag: #belgian;
		addTag: #thriller.
	album := library addAlbum: (CBAlbum new
			          series: (library seriesNamed: 'XIII');
			          publisher: (library publisherNamed: 'Dargaud');
			          title: 'Le jour du "soleil" noir';
			          number: 1;
			          year: 1984;
			          entryNumber: 5;
			          entryDate: (Date year: 2006 month: 3 day: 25);
			          notes: 'a & b';
			          yourself).
	album addAuthor: (library authorNamed: 'Van Hamme').
	album addAuthor: (library authorNamed: 'Vance').
	library addWanted: ((CBWantedAlbum seriesName: 'XIII' number: 2)
			 title: 'Là où va l''Indien';
			 yourself)
]

{ #category : 'tests' }
CBXMLExporterTest >> testAlbumsAreWrittenByEntryNumber [

	| contents |
	library addAlbum: (CBAlbum new
			 series: (library seriesNamed: 'XIII');
			 title: 'first';
			 entryNumber: 1;
			 yourself).
	contents := (CBXMLExporter on: library) contents.
	self assert: (contents indexOfSubCollection: 'title="first"') < (contents indexOfSubCollection: 'soleil')
]

{ #category : 'tests' }
CBXMLExporterTest >> testContents [

	| contents |
	contents := (CBXMLExporter on: library) contents.
	self assert: (contents beginsWith: '<?xml version="1.0" encoding="UTF-8"?>').
	self assert: (contents includesSubstring: 'format="2"').
	self assert: (contents includesSubstring: 'entriesNumber="1"').
	self assert: (contents includesSubstring: 'authors="Van Hamme and Vance"').
	self assert: (contents includesSubstring: 'tags="belgian thriller"').
	self assert: (contents includesSubstring: 'entryCreationDate="25 March 2006"').
	self assert: (contents includesSubstring: 'title="Le jour du &quot;soleil&quot; noir"').
	self assert: (contents includesSubstring: 'notes="a &amp; b"').
	self assert: (contents includesSubstring: '<wanted seriesName="XIII" number="2"').
	self assert: (contents endsWith: '</Base>' , String lf)
]

{ #category : 'tests' }
CBXMLExporterTest >> testPrintDate [

	self assert: ((CBXMLExporter on: library) printDate: (Date year: 2007 month: 4 day: 1)) equals: '1 April 2007'
]

{ #category : 'tests' }
CBXMLExporterTest >> testRoundTrip [

	| loaded album wanted |
	loaded := CBLibrary new.
	(CBXMLImporter on: loaded) importString: (CBXMLExporter on: library) contents.
	album := loaded owned albums first.
	self assert: album title equals: 'Le jour du "soleil" noir'.
	self assert: album number equals: 1.
	self assert: album year equals: 1984.
	self assert: album entryNumber equals: 5.
	self assert: album entryDate equals: (Date year: 2006 month: 3 day: 25).
	self assert: album notes equals: 'a & b'.
	self assert: album publisher name equals: 'Dargaud'.
	self assert: (album authors collect: [ :each | each name ]) asArray equals: #( 'Van Hamme' 'Vance' ).
	self assert: album tags equals: #( #belgian #thriller ) asSet.
	wanted := loaded wanted entries first.
	self assert: wanted seriesName equals: 'XIII'.
	self assert: wanted title equals: 'Là où va l''Indien'
]

{ #category : 'tests' }
CBXMLExporterTest >> testWriteTo [

	| file |
	file := FileSystem memory root / 'out.xml'.
	(CBXMLExporter on: library) writeTo: file.
	self assert: file contents equals: (CBXMLExporter on: library) contents
]
