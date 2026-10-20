"
I represent a series. I hold only the albums that are owned. A one-shot is a series with a single album.
My tags (symbols) classify all my albums and are used to build projections.
"
Class {
	#name : 'CBSeries',
	#superclass : 'Object',
	#instVars : [
		'name',
		'isComplete',
		'tags',
		'albums'
	],
	#category : 'CBComix',
	#package : 'CBComix'
}

{ #category : 'instance creation' }
CBSeries class >> named: aString [

	^ self new
		  name: aString;
		  yourself
]

{ #category : 'albums' }
CBSeries >> addAlbum: anAlbum [

	(albums includes: anAlbum) ifFalse: [ albums add: anAlbum ].
	^ anAlbum
]

{ #category : 'tags' }
CBSeries >> addTag: aSymbol [

	tags add: aSymbol asSymbol
]

{ #category : 'albums' }
CBSeries >> albums [

	^ albums copy
]

{ #category : 'tags' }
CBSeries >> hasTag: aSymbol [

	^ tags includes: aSymbol asSymbol
]

{ #category : 'initialization' }
CBSeries >> initialize [

	super initialize.
	name := ''.
	isComplete := false.
	tags := Set new.
	albums := OrderedCollection new
]

{ #category : 'accessing' }
CBSeries >> isComplete [

	^ isComplete
]

{ #category : 'accessing' }
CBSeries >> isComplete: aBoolean [

	isComplete := aBoolean
]

{ #category : 'testing' }
CBSeries >> isOneShot [

	^ albums size = 1
]

{ #category : 'accessing' }
CBSeries >> name [

	^ name
]

{ #category : 'accessing' }
CBSeries >> name: aString [

	name := aString
]

{ #category : 'printing' }
CBSeries >> printOn: aStream [

	aStream nextPutAll: name
]

{ #category : 'albums' }
CBSeries >> removeAlbum: anAlbum [

	albums remove: anAlbum ifAbsent: [ ]
]

{ #category : 'tags' }
CBSeries >> removeTag: aSymbol [

	tags remove: aSymbol asSymbol ifAbsent: [ ]
]

{ #category : 'albums' }
CBSeries >> sortedAlbums [

	^ albums asArray sorted: [ :a :b | a number <= b number ]
]

{ #category : 'tags' }
CBSeries >> tags [

	^ tags copy
]
