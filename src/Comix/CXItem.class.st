Class {
	#name : #CXItem,
	#superclass : #Object,
	#instVars : [
		'title',
		'notes',
		'sortedAs',
		'base',
		'entryCreationDate',
		'entryNumber',
		'editor',
		'year',
		'mainSerie',
		'serie',
		'original',
		'depotLegal',
		'castermanNote',
		'authors',
		'ISBN',
		'number',
		'numberOnCover',
		'serieComplete',
		'coverPictureName',
		'collection'
	],
	#category : #'Comix-Model'
}

{ #category : #accessing }
CXItem >> authors [
	^ authors

]

{ #category : #accessing }
CXItem >> authors: aValue [
	authors := aValue

]

{ #category : #accessing }
CXItem >> castermanNote [
	^ castermanNote

]

{ #category : #accessing }
CXItem >> castermanNote: aValue [
	castermanNote := aValue

]

{ #category : #accessing }
CXItem >> collection [
	^ collection

]

{ #category : #accessing }
CXItem >> collection: aValue [
	collection := aValue

]

{ #category : #accessing }
CXItem >> coverPictureName [
	^ coverPictureName

]

{ #category : #accessing }
CXItem >> coverPictureName: aValue [
	coverPictureName := aValue

]

{ #category : #accessing }
CXItem >> depotLegal [
	^ depotLegal

]

{ #category : #accessing }
CXItem >> depotLegal: aValue [
	depotLegal := aValue

]

{ #category : #accessing }
CXItem >> editor [
	^ editor

]

{ #category : #accessing }
CXItem >> editor: aValue [
	editor := aValue

]

{ #category : #accessing }
CXItem >> entryCreationDate [
	^ entryCreationDate

]

{ #category : #accessing }
CXItem >> entryCreationDate: aValue [
	entryCreationDate := aValue

]

{ #category : #accessing }
CXItem >> entryNumber [
	^ entryNumber

]

{ #category : #accessing }
CXItem >> entryNumber: aValue [
	entryNumber := aValue

]

{ #category : #'accessing - composed' }
CXItem >> hasNumber [


	^ self publicNumber isNil not
]

{ #category : #'import from xml' }
CXItem >> importAuthors: aString [
	self authors: aString

]

{ #category : #'import from xml' }
CXItem >> importCastermanNote: aString [
	self castermanNote: aString
]

{ #category : #'import from xml' }
CXItem >> importCollection: aString [
	self collection: aString

]

{ #category : #'import from xml' }
CXItem >> importCoverPictureName: aString [
	self coverPictureName: aString

]

{ #category : #'import from xml' }
CXItem >> importDepotLegal: aDate [
	self depotLegal: aDate
]

{ #category : #'import from xml' }
CXItem >> importEditor: aString [
	self editor: aString

]

{ #category : #accessing }
CXItem >> importEntryCreationDate: aValue [
	self entryCreationDate: (Date readFromString: aValue)

]

{ #category : #'import from xml' }
CXItem >> importEntryNumber: anInteger [

	(anInteger isKindOf: Number)
		ifTrue: [ self number: anInteger ]
		ifFalse: [ self number: (Integer readFromString: anInteger) ]

]

{ #category : #'import from xml' }
CXItem >> importMainSerie: aString [
	self mainSerie: aString

]

{ #category : #'import from xml' }
CXItem >> importNotes: aValue [
	self notes: aValue asString

]

{ #category : #'import from xml' }
CXItem >> importNumber: anInteger [

	(anInteger isKindOf: Number)
		ifTrue: [ self number: anInteger ]
		ifFalse: [ self number: (Integer readFromString: anInteger) ]

]

{ #category : #'import from xml' }
CXItem >> importNumberOnCover: anInteger [

	(anInteger isKindOf: Number)
		ifTrue: [ self numberOnCover: anInteger ]
		ifFalse: [ self numberOnCover: (Integer readFromString: anInteger) ]

]

{ #category : #'import from xml' }
CXItem >> importOriginal: aValue [

	(aValue isKindOf: Boolean)
		ifTrue: [ self original: aValue ]
		ifFalse: [ self original: (Boolean readFromString: aValue) ]

]

{ #category : #'import from xml' }
CXItem >> importSerie: aValue [
	self serie: aValue

]

{ #category : #'import from xml' }
CXItem >> importSerieComplete: aValue [
	self serieComplete: (Object readFromString: aValue)

]

{ #category : #'import from xml' }
CXItem >> importSortedAs: aString [
	self sortedAs: aString asString

]

{ #category : #'import from xml' }
CXItem >> importTitle: aString [
	self title: aString asString

]

{ #category : #'import from xml' }
CXItem >> importYear: anInteger [

	(anInteger isKindOf: Year)
		ifTrue: [ self year: anInteger ]
		ifFalse: [ self year: (Integer readFromString: anInteger) ]

]

{ #category : #accessing }
CXItem >> mainSerie [
	^ mainSerie

]

{ #category : #accessing }
CXItem >> mainSerie: aValue [
	mainSerie := aValue

]

{ #category : #accessing }
CXItem >> notes [
	^ notes

]

{ #category : #accessing }
CXItem >> notes: aValue [
	notes := aValue

]

{ #category : #accessing }
CXItem >> number [
	^ number

]

{ #category : #accessing }
CXItem >> number: aValue [
	number := aValue

]

{ #category : #accessing }
CXItem >> numberOnCover [
	^ numberOnCover

]

{ #category : #accessing }
CXItem >> numberOnCover: aValue [
	numberOnCover := aValue

]

{ #category : #accessing }
CXItem >> original [
	^ original

]

{ #category : #accessing }
CXItem >> original: aValue [
	original := aValue

]

{ #category : #printing }
CXItem >> printOn: aStream [
	
	aStream nextPutAll: self title.
]

{ #category : #'accessing - composed' }
CXItem >> publicNumber [
	^ number ifNil: [self numberOnCover isNil ifTrue: [0] ifFalse: [self numberOnCover]]
	
]

{ #category : #accessing }
CXItem >> serie [
	^ serie

]

{ #category : #accessing }
CXItem >> serie: aValue [
	serie := aValue

]

{ #category : #accessing }
CXItem >> serieComplete [
	^ serieComplete

]

{ #category : #accessing }
CXItem >> serieComplete: aValue [
	serieComplete := aValue

]

{ #category : #accessing }
CXItem >> serieTitle [
	"for now it will just be the serie but when serie got connected it will change"
	
	^ serie
]

{ #category : #accessing }
CXItem >> sortedAs [
	"An item is sorted within a serie as an explicit number, when there is a mess
	in the numbering or via its public number"
	^ sortedAs ifNil: [ self publicNumber asString ]

]

{ #category : #accessing }
CXItem >> sortedAs: aValue [
	sortedAs := aValue asString

]

{ #category : #accessing }
CXItem >> title [
	^ title

]

{ #category : #accessing }
CXItem >> title: aValue [
	title := aValue asString

]

{ #category : #accessing }
CXItem >> year [
	^ year

]

{ #category : #accessing }
CXItem >> year: aValue [
	year := aValue

]
