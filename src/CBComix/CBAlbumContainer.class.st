"
I am the common protocol of collections of albums: the owned book collection and the projections built on it.
My subclasses define #albums.
"
Class {
	#name : 'CBAlbumContainer',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'CBComix',
	#package : 'CBComix'
}

{ #category : 'testing' }
CBAlbumContainer class >> isAbstract [

	^ self == CBAlbumContainer
]

{ #category : 'accessing' }
CBAlbumContainer >> albums [

	^ self subclassResponsibility
]

{ #category : 'querying' }
CBAlbumContainer >> albumsOfSeries: aSeries [

	^ self select: [ :each | each series == aSeries ]
]

{ #category : 'querying' }
CBAlbumContainer >> albumsSortedBy: aBlock [

	^ self albums asArray sorted: aBlock
]

{ #category : 'querying' }
CBAlbumContainer >> albumsWithTag: aSymbol [

	^ self select: [ :each | each hasTag: aSymbol ]
]

{ #category : 'querying' }
CBAlbumContainer >> detect: aBlock ifNone: anotherBlock [

	^ self albums detect: aBlock ifNone: anotherBlock
]

{ #category : 'enumerating' }
CBAlbumContainer >> do: aBlock [

	self albums do: aBlock
]

{ #category : 'testing' }
CBAlbumContainer >> includes: anAlbum [

	^ self albums includes: anAlbum
]

{ #category : 'initialization' }
CBAlbumContainer >> initialize [

	super initialize.
	name := ''
]

{ #category : 'testing' }
CBAlbumContainer >> isEmpty [

	^ self albums isEmpty
]

{ #category : 'accessing' }
CBAlbumContainer >> name [

	^ name
]

{ #category : 'accessing' }
CBAlbumContainer >> name: aString [

	name := aString
]

{ #category : 'printing' }
CBAlbumContainer >> printOn: aStream [

	aStream
		nextPutAll: name;
		nextPutAll: ' (';
		print: self size;
		nextPutAll: ' albums)'
]

{ #category : 'projections' }
CBAlbumContainer >> projectionNamed: aString rule: aBlock [

	^ CBProjection named: aString on: self rule: aBlock
]

{ #category : 'querying' }
CBAlbumContainer >> select: aBlock [

	^ self albums select: aBlock
]

{ #category : 'accessing' }
CBAlbumContainer >> size [

	^ self albums size
]
