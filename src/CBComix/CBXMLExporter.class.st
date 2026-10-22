"
I export a library to XML, in the historical BD.xxx.xml format extended with:
- a format=""2"" attribute on Base,
- a tags attribute on each bd (the tags of its series),
- authors joined with ' and ',
- one wanted element per wanted album.
CBXMLImporter reads my output back.
"
Class {
	#name : 'CBXMLExporter',
	#superclass : 'Object',
	#instVars : [
		'library'
	],
	#category : 'CBComix-ImportExport',
	#package : 'CBComix',
	#tag : 'ImportExport'
}

{ #category : 'instance creation' }
CBXMLExporter class >> on: aLibrary [

	^ self new
		  library: aLibrary;
		  yourself
]

{ #category : 'exporting' }
CBXMLExporter >> contents [

	^ String streamContents: [ :stream | self writeOn: stream ]
]

{ #category : 'accessing' }
CBXMLExporter >> library [

	^ library
]

{ #category : 'accessing' }
CBXMLExporter >> library: aLibrary [

	library := aLibrary
]

{ #category : 'private' }
CBXMLExporter >> printDate: aDate [

	^ aDate dayOfMonth printString , ' ' , aDate monthName , ' ' , aDate year printString
]

{ #category : 'private' }
CBXMLExporter >> write: aName value: aString on: aStream [

	aStream
		space;
		nextPutAll: aName;
		nextPutAll: '="';
		nextPutAll: (CBFlatManualXMLReader encode: aString);
		nextPut: $"
]

{ #category : 'private' }
CBXMLExporter >> writeAlbum: anAlbum on: aStream [

	aStream nextPutAll: '    <bd'.
	self write: 'serieComplete' value: anAlbum series isComplete printString on: aStream.
	self write: 'editor' value: anAlbum publisher name on: aStream.
	self write: 'entryCreationDate' value: (self printDate: anAlbum entryDate) on: aStream.
	self write: 'entryNumber' value: anAlbum entryNumber printString on: aStream.
	self write: 'authors' value: (' and ' join: (anAlbum authors collect: [ :each | each name ])) on: aStream.
	self write: 'title' value: anAlbum title on: aStream.
	self write: 'serie' value: anAlbum series name on: aStream.
	self write: 'original' value: anAlbum isOriginal printString on: aStream.
	self write: 'notes' value: anAlbum notes on: aStream.
	self write: 'number' value: anAlbum number printString on: aStream.
	self write: 'year' value: anAlbum year printString on: aStream.
	self write: 'tags' value: (' ' join: (anAlbum tags asArray sorted collect: [ :each | each asString ])) on: aStream.
	aStream
		nextPutAll: ' />';
		lf
]

{ #category : 'exporting' }
CBXMLExporter >> writeOn: aStream [

	aStream
		nextPutAll: '<?xml version="1.0" encoding="UTF-8"?>';
		lf.
	aStream nextPutAll: '<Base'.
	self write: 'date' value: (self printDate: Date today) on: aStream.
	self write: 'entriesNumber' value: library owned size printString on: aStream.
	self write: 'format' value: '2' on: aStream.
	aStream
		nextPutAll: '>';
		lf.
	(library owned albumsSortedBy: [ :a :b | a entryNumber <= b entryNumber ]) do: [ :each | self writeAlbum: each on: aStream ].
	library wanted do: [ :each | self writeWanted: each on: aStream ].
	aStream
		nextPutAll: '</Base>';
		lf
]

{ #category : 'exporting' }
CBXMLExporter >> writeTo: aFileReference [

	aFileReference ensureDelete.
	aFileReference writeStreamDo: [ :stream | self writeOn: stream ]
]

{ #category : 'private' }
CBXMLExporter >> writeWanted: aWantedAlbum on: aStream [

	aStream nextPutAll: '    <wanted'.
	self write: 'seriesName' value: aWantedAlbum seriesName on: aStream.
	self write: 'number' value: aWantedAlbum number printString on: aStream.
	self write: 'title' value: aWantedAlbum title on: aStream.
	self write: 'notes' value: aWantedAlbum notes on: aStream.
	aStream
		nextPutAll: ' />';
		lf
]
