"
I represent an album that is owned. I point to my shared series, publisher and authors.
A number or year of 0 means unknown.
"
Class {
	#name : 'CBAlbum',
	#superclass : 'Object',
	#instVars : [
		'title',
		'number',
		'year',
		'isOriginal',
		'notes',
		'entryNumber',
		'entryDate',
		'series',
		'publisher',
		'authors'
	],
	#category : 'CBComix-Core',
	#package : 'CBComix',
	#tag : 'Core'
}

{ #category : 'authors' }
CBAlbum >> addAuthor: anAuthor [

	(authors includes: anAuthor) ifFalse: [ authors add: anAuthor ].
	^ anAuthor
]

{ #category : 'authors' }
CBAlbum >> authors [

	^ authors copy
]

{ #category : 'printing' }
CBAlbum >> displayStringOn: aStream [

	aStream
		displayPrint: series;
		space;
		displayPrint: number;
		nextPutAll: ' - ';
		nextPutAll: title
]

{ #category : 'accessing' }
CBAlbum >> entryDate [

	^ entryDate
]

{ #category : 'accessing' }
CBAlbum >> entryDate: aDate [

	entryDate := aDate
]

{ #category : 'accessing' }
CBAlbum >> entryNumber [

	^ entryNumber
]

{ #category : 'accessing' }
CBAlbum >> entryNumber: anInteger [

	entryNumber := anInteger
]

{ #category : 'testing' }
CBAlbum >> hasNumber [

	^ number > 0
]

{ #category : 'tags' }
CBAlbum >> hasTag: aSymbol [

	^ series hasTag: aSymbol
]

{ #category : 'testing' }
CBAlbum >> hasYear [

	^ year > 0
]

{ #category : 'initialization' }
CBAlbum >> initialize [

	super initialize.
	title := ''.
	number := 0.
	year := 0.
	isOriginal := true.
	notes := ''.
	entryNumber := 0.
	entryDate := Date today.
	publisher := CBPublisher new.
	authors := OrderedCollection new
]

{ #category : 'accessing' }
CBAlbum >> isOriginal [

	^ isOriginal
]

{ #category : 'accessing' }
CBAlbum >> isOriginal: aBoolean [

	isOriginal := aBoolean
]

{ #category : 'accessing' }
CBAlbum >> notes [

	^ notes
]

{ #category : 'accessing' }
CBAlbum >> notes: aString [

	notes := aString
]

{ #category : 'accessing' }
CBAlbum >> number [

	^ number
]

{ #category : 'accessing' }
CBAlbum >> number: anInteger [

	number := anInteger
]

{ #category : 'printing' }
CBAlbum >> printOn: aStream [

	super printOn: aStream. 
	aStream
		nextPutAll: ' (';
		print: series;
		space;
		print: number;
		nextPutAll: ' - ';
		nextPutAll: title;
		nextPutAll: ')'
]

{ #category : 'accessing' }
CBAlbum >> publisher [

	^ publisher
]

{ #category : 'accessing' }
CBAlbum >> publisher: aPublisher [

	publisher := aPublisher
]

{ #category : 'authors' }
CBAlbum >> removeAuthor: anAuthor [

	authors remove: anAuthor ifAbsent: [ ]
]

{ #category : 'accessing' }
CBAlbum >> series [

	^ series
]

{ #category : 'accessing' }
CBAlbum >> series: aSeries [

	series := aSeries
]

{ #category : 'tags' }
CBAlbum >> tags [

	^ series tags
]

{ #category : 'accessing' }
CBAlbum >> title [

	^ title
]

{ #category : 'accessing' }
CBAlbum >> title: aString [

	title := aString
]

{ #category : 'accessing' }
CBAlbum >> year [

	^ year
]

{ #category : 'accessing' }
CBAlbum >> year: anInteger [

	year := anInteger
]
