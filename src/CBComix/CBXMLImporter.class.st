"
I import albums and wanted albums from the XML format into a library.
I read both the historical format (BD.xxx.xml) and the format written by CBXMLExporter (format=""2"").
In the historical format, authors not written as 'Last, First and ...' are split on spaces (best guess).
"
Class {
	#name : 'CBXMLImporter',
	#superclass : 'Object',
	#instVars : [
		'library',
		'format'
	],
	#category : 'CBComix-ImportExport',
	#package : 'CBComix',
	#tag : 'ImportExport'
}

{ #category : 'instance creation' }
CBXMLImporter class >> on: aLibrary [

	^ self new
		  library: aLibrary;
		  yourself
]

{ #category : 'parsing' }
CBXMLImporter >> authorNamesFrom: aString [

	(format = '2' or: [ aString includesSubstring: ',' ]) ifFalse: [ ^ aString substrings ].
	^ ((' and ' split: aString) collect: [ :each | each trimBoth ]) reject: [ :each | each isEmpty ]
]

{ #category : 'parsing' }
CBXMLImporter >> dateFrom: aString [

	| parts |
	parts := aString substrings.
	parts size = 3 ifFalse: [ ^ Date today ].
	^ Date year: parts third asNumber month: (Date indexOfMonth: parts second) day: parts first asNumber
]

{ #category : 'accessing' }
CBXMLImporter >> format [

	^ format
]

{ #category : 'private' }
CBXMLImporter >> handlers [

	^ Dictionary newFrom: {
			  ('Base' -> #importBase:).
			  ('bd' -> #importAlbum:).
			  ('wanted' -> #importWanted:) }
]

{ #category : 'importing' }
CBXMLImporter >> importAlbum: attributes [

	| series album |
	series := library seriesNamed: (attributes at: 'serie' ifAbsent: [ '' ]).
	(attributes at: 'serieComplete' ifAbsent: [ 'false' ]) = 'true' ifTrue: [ series isComplete: true ].
	(attributes at: 'tags' ifAbsent: [ '' ]) substrings do: [ :each | series addTag: each asSymbol ].
	album := CBAlbum new
		         title: (attributes at: 'title' ifAbsent: [ '' ]);
		         number: (self integerFrom: (attributes at: 'number' ifAbsent: [ '' ]));
		         year: (self integerFrom: (attributes at: 'year' ifAbsent: [ '' ]));
		         isOriginal: (attributes at: 'original' ifAbsent: [ 'true' ]) = 'true';
		         notes: (attributes at: 'notes' ifAbsent: [ '' ]);
		         entryNumber: (self integerFrom: (attributes at: 'entryNumber' ifAbsent: [ '' ]));
		         entryDate: (self dateFrom: (attributes at: 'entryCreationDate' ifAbsent: [ '' ]));
		         series: series;
		         publisher: (library publisherNamed: (attributes at: 'editor' ifAbsent: [ '' ]));
		         yourself.
	(self authorNamesFrom: (attributes at: 'authors' ifAbsent: [ '' ])) do: [ :each | album addAuthor: (library authorNamed: each) ].
	^ library addAlbum: album
]

{ #category : 'importing' }
CBXMLImporter >> importBase: attributes [

	format := attributes at: 'format' ifAbsent: [ '1' ]
]

{ #category : 'importing' }
CBXMLImporter >> importElement: anAssociation [

	self perform: (self handlers at: anAssociation key ifAbsent: [ ^ self ]) with: anAssociation value
]

{ #category : 'importing' }
CBXMLImporter >> importFile: aFileReference [

	self importString: aFileReference contents
]

{ #category : 'importing' }
CBXMLImporter >> importString: aString [

	(CBFlatManualXMLReader new elementsIn: aString) 
		do: [ :each | self importElement: each ].
	library rebuildProjections
]

{ #category : 'importing' }
CBXMLImporter >> importWanted: attributes [

	^ library addWanted: (CBWantedAlbum new
			   seriesName: (attributes at: 'seriesName' ifAbsent: [ '' ]);
			   number: (self integerFrom: (attributes at: 'number' ifAbsent: [ '' ]));
			   title: (attributes at: 'title' ifAbsent: [ '' ]);
			   notes: (attributes at: 'notes' ifAbsent: [ '' ]);
			   yourself)
]

{ #category : 'initialization' }
CBXMLImporter >> initialize [

	super initialize.
	format := '1'
]

{ #category : 'parsing' }
CBXMLImporter >> integerFrom: aString [

	^ (aString notEmpty and: [ aString allSatisfy: [ :each | each isDigit ] ])
		  ifTrue: [ aString asNumber ]
		  ifFalse: [ 0 ]
]

{ #category : 'accessing' }
CBXMLImporter >> library [

	^ library
]

{ #category : 'accessing' }
CBXMLImporter >> library: aLibrary [

	library := aLibrary
]
