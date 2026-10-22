"
I represent an album I am looking for. I am text only: I do not refer to shared series, authors or publishers.
A number of 0 means unknown.
"
Class {
	#name : 'CBWantedAlbum',
	#superclass : 'Object',
	#instVars : [
		'seriesName',
		'number',
		'title',
		'notes'
	],
	#category : 'CBComix-Core',
	#package : 'CBComix',
	#tag : 'Core'
}

{ #category : 'instance creation' }
CBWantedAlbum class >> seriesName: aString number: anInteger [

	^ self new
		  seriesName: aString;
		  number: anInteger;
		  yourself
]

{ #category : 'testing' }
CBWantedAlbum >> hasNumber [

	^ number > 0
]

{ #category : 'initialization' }
CBWantedAlbum >> initialize [

	super initialize.
	seriesName := ''.
	number := 0.
	title := ''.
	notes := ''
]

{ #category : 'testing' }
CBWantedAlbum >> isInSeriesNamed: aString [

	^ (CBLibrary normalize: seriesName) = (CBLibrary normalize: aString)
]

{ #category : 'accessing' }
CBWantedAlbum >> notes [

	^ notes
]

{ #category : 'accessing' }
CBWantedAlbum >> notes: aString [

	notes := aString
]

{ #category : 'accessing' }
CBWantedAlbum >> number [

	^ number
]

{ #category : 'accessing' }
CBWantedAlbum >> number: anInteger [

	number := anInteger
]

{ #category : 'printing' }
CBWantedAlbum >> printOn: aStream [

	aStream
		nextPutAll: 'wanted: ';
		nextPutAll: seriesName;
		space;
		print: number
]

{ #category : 'accessing' }
CBWantedAlbum >> seriesName [

	^ seriesName
]

{ #category : 'accessing' }
CBWantedAlbum >> seriesName: aString [

	seriesName := aString
]

{ #category : 'accessing' }
CBWantedAlbum >> title [

	^ title
]

{ #category : 'accessing' }
CBWantedAlbum >> title: aString [

	title := aString
]
