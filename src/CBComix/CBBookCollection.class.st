"
I hold albums. The library uses me for its owned collection; projections are built on me.
"
Class {
	#name : 'CBBookCollection',
	#superclass : 'CBAlbumContainer',
	#instVars : [
		'albums'
	],
	#category : 'CBComix',
	#package : 'CBComix'
}

{ #category : 'instance creation' }
CBBookCollection class >> named: aString [

	^ self new
		  name: aString;
		  yourself
]

{ #category : 'adding' }
CBBookCollection >> add: anAlbum [

	(albums includes: anAlbum) ifFalse: [ albums add: anAlbum ].
	^ anAlbum
]

{ #category : 'accessing' }
CBBookCollection >> albums [

	^ albums copy
]

{ #category : 'initialization' }
CBBookCollection >> initialize [

	super initialize.
	albums := OrderedCollection new
]

{ #category : 'removing' }
CBBookCollection >> remove: anAlbum [

	albums remove: anAlbum ifAbsent: [ ]
]
