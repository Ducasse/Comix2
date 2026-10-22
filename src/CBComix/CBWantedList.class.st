"
I hold the albums I am looking for (CBWantedAlbum). I share nothing with the owned collection.
"
Class {
	#name : 'CBWantedList',
	#superclass : 'Object',
	#instVars : [
		'entries'
	],
	#category : 'CBComix-Core',
	#package : 'CBComix',
	#tag : 'Core'
}

{ #category : 'adding' }
CBWantedList >> add: aWantedAlbum [

	(entries includes: aWantedAlbum) ifFalse: [ entries add: aWantedAlbum ].
	^ aWantedAlbum
]

{ #category : 'enumerating' }
CBWantedList >> do: aBlock [

	entries do: aBlock
]

{ #category : 'accessing' }
CBWantedList >> entries [

	^ entries copy
]

{ #category : 'querying' }
CBWantedList >> entriesForSeriesNamed: aString [

	^ entries select: [ :each | each isInSeriesNamed: aString ]
]

{ #category : 'testing' }
CBWantedList >> includes: aWantedAlbum [

	^ entries includes: aWantedAlbum
]

{ #category : 'initialization' }
CBWantedList >> initialize [

	super initialize.
	entries := OrderedCollection new
]

{ #category : 'testing' }
CBWantedList >> isEmpty [

	^ entries isEmpty
]

{ #category : 'removing' }
CBWantedList >> remove: aWantedAlbum [

	entries remove: aWantedAlbum ifAbsent: [ ]
]

{ #category : 'accessing' }
CBWantedList >> size [

	^ entries size
]
