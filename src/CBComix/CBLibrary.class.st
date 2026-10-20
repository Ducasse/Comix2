"
I am the root of the model. I own:
- the registries of series, authors and publishers (unique by normalized name),
- the owned collection (the main one),
- the wanted list (independent from owned),
- the projections, one per tag, rebuilt from owned (they are not saved).

CBLibrary current is the library living in the image.
"
Class {
	#name : 'CBLibrary',
	#superclass : 'Object',
	#instVars : [
		'series',
		'authors',
		'publishers',
		'owned',
		'wanted',
		'projections'
	],
	#classInstVars : [
		'current'
	],
	#category : 'CBComix',
	#package : 'CBComix'
}

{ #category : 'accessing' }
CBLibrary class >> current [

	^ current
]

{ #category : 'persistence' }
CBLibrary class >> fromSTONFile: aFileReference [

	^ (aFileReference readStreamDo: [ :stream | STON fromStream: stream ])
		  rebuildProjections;
		  yourself
]

{ #category : 'persistence' }
CBLibrary class >> fromXMLFile: aFileReference [

	| library |
	library := self new.
	(CBXMLImporter on: library) importFile: aFileReference.
	^ library
]

{ #category : 'class initialization' }
CBLibrary class >> initialize [

	self reset
]

{ #category : 'normalizing' }
CBLibrary class >> normalize: aString [

	^ aString trimBoth asLowercase
]

{ #category : 'class initialization' }
CBLibrary class >> reset [

	current := self new
]

{ #category : 'persistence' }
CBLibrary class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithout: #projections
]

{ #category : 'buying' }
CBLibrary >> acquire: aWantedAlbum [

	| album |
	album := CBAlbum new
		         title: aWantedAlbum title;
		         number: aWantedAlbum number;
		         notes: aWantedAlbum notes;
		         series: (self seriesNamed: aWantedAlbum seriesName);
		         publisher: self unknownPublisher;
		         entryNumber: self nextEntryNumber;
		         entryDate: Date today;
		         yourself.
	self addAlbum: album.
	wanted remove: aWantedAlbum.
	^ album
]

{ #category : 'owned' }
CBLibrary >> addAlbum: anAlbum [

	owned add: anAlbum.
	anAlbum series addAlbum: anAlbum.
	^ anAlbum
]

{ #category : 'projections' }
CBLibrary >> addProjection: aProjection [

	projections at: aProjection name asSymbol put: aProjection.
	^ aProjection
]

{ #category : 'wanted' }
CBLibrary >> addWanted: aWantedAlbum [

	^ wanted add: aWantedAlbum
]

{ #category : 'registries' }
CBLibrary >> allAuthors [

	^ authors values
]

{ #category : 'registries' }
CBLibrary >> allPublishers [

	^ publishers values
]

{ #category : 'registries' }
CBLibrary >> allSeries [

	^ series values
]

{ #category : 'tags' }
CBLibrary >> allTags [

	^ series values inject: Set new into: [ :result :each |
			  result addAll: each tags.
			  result ]
]

{ #category : 'registries' }
CBLibrary >> authorNamed: aString [

	^ authors at: (self class normalize: aString) ifAbsentPut: [ CBAuthor named: aString trimBoth ]
]

{ #category : 'persistence' }
CBLibrary >> exportSTONTo: aFileReference [

	aFileReference ensureDelete.
	aFileReference writeStreamDo: [ :stream | STON put: self onStreamPretty: stream ]
]

{ #category : 'persistence' }
CBLibrary >> exportXMLTo: aFileReference [

	(CBXMLExporter on: self) writeTo: aFileReference
]

{ #category : 'registries' }
CBLibrary >> hasSeriesNamed: aString [

	^ series includesKey: (self class normalize: aString)
]

{ #category : 'initialization' }
CBLibrary >> initialize [

	super initialize.
	series := Dictionary new.
	authors := Dictionary new.
	publishers := Dictionary new.
	owned := CBBookCollection named: 'owned'.
	wanted := CBWantedList new.
	projections := Dictionary new
]

{ #category : 'owned' }
CBLibrary >> nextEntryNumber [

	^ (owned albums inject: 0 into: [ :max :each | max max: each entryNumber ]) + 1
]

{ #category : 'accessing' }
CBLibrary >> owned [

	^ owned
]

{ #category : 'owned' }
CBLibrary >> owns: anAlbum [

	^ owned includes: anAlbum
]

{ #category : 'projections' }
CBLibrary >> projectionNamed: aString [

	^ projections at: aString asSymbol
]

{ #category : 'projections' }
CBLibrary >> projections [

	^ projections copy
]

{ #category : 'registries' }
CBLibrary >> publisherNamed: aString [

	^ publishers at: (self class normalize: aString) ifAbsentPut: [ CBPublisher named: aString trimBoth ]
]

{ #category : 'projections' }
CBLibrary >> rebuildProjections [

	projections := Dictionary new.
	self allTags do: [ :tag | self addProjection: (owned projectionNamed: tag asString rule: [ :album | album hasTag: tag ]) ]
]

{ #category : 'owned' }
CBLibrary >> removeAlbum: anAlbum [

	owned remove: anAlbum.
	anAlbum series removeAlbum: anAlbum
]

{ #category : 'registries' }
CBLibrary >> seriesNamed: aString [

	^ series at: (self class normalize: aString) ifAbsentPut: [ CBSeries named: aString trimBoth ]
]

{ #category : 'registries' }
CBLibrary >> unknownPublisher [

	^ self publisherNamed: ''
]

{ #category : 'accessing' }
CBLibrary >> wanted [

	^ wanted
]
