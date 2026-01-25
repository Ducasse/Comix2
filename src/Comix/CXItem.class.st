Class {
	#name : 'CXItem',
	#superclass : 'Object',
	#instVars : [
		'title',
		'collectionState',
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
	#category : 'Comix-Model',
	#package : 'Comix',
	#tag : 'Model'
}

{ #category : 'sample' }
CXItem class >> nic [
	"self nic"
	
	^ STON fromString: 

'CXItem {
	#title : ''Total souk pour nic oumouk'',
	#entryCreationDate : Date [ ''2006-03-25+01:00'' ],
	#entryNumber : 1,
	#editor : ''Dargaud'',
	#year : 2005,
	#serie : CXSerie {
		#title : ''Nic oumouk'',
		#sortedAs : ''Nic oumouk'',
		#serieComplete : false,
		#bds : OrderedCollection [
			@1,
			CXItem {
				#title : ''La france a peur'',
				#entryCreationDate : Date [ ''2007-03-25+01:00'' ],
				#entryNumber : 1809,
				#editor : ''Dargaud'',
				#year : 2007,
				#serie : @3,
				#original : true,
				#authors : ''Larcenet'',
				#number : 2,
				#serieComplete : false
			}
		]
	},
	#original : true,
	#authors : ''Larcenet'',
	#number : 1,
	#serieComplete : false
}'
]

{ #category : 'testing' }
CXItem >> <= anItem [
	
	^  self title ifNil: [ self number <= anItem number] ifNotNil: [ self title <= anItem title ]
]

{ #category : 'accessing' }
CXItem >> ISBN [
	^ ISBN
]

{ #category : 'accessing' }
CXItem >> ISBN: aString [
	ISBN := aString
]

{ #category : 'visiting' }
CXItem >> accept: aVisitor [

	aVisitor visitItem: self
]

{ #category : 'export to xml' }
CXItem >> asXML [
	
	| xmlW tag |
	xmlW := XMLWriter new.
	tag := xmlW tag: 'bd'.
	self serializableInstanceVariables sorted
		do: [ :v |
			| value |
			value := self perform: v.
			value ifNotNil: [ tag attributeAt: v put: value asString ] ].
	^ xmlW contents	
]

{ #category : 'accessing' }
CXItem >> authors [
	^ authors

]

{ #category : 'accessing' }
CXItem >> authors: aValue [
	authors := aValue

]

{ #category : 'accessing' }
CXItem >> castermanNote [
	^ castermanNote

]

{ #category : 'accessing' }
CXItem >> castermanNote: aValue [
	castermanNote := aValue

]

{ #category : 'accessing' }
CXItem >> collection [
	^ collection

]

{ #category : 'accessing' }
CXItem >> collection: aValue [
	collection := aValue

]

{ #category : 'accessing' }
CXItem >> collectionState [
	
	^ collectionState
]

{ #category : 'accessing' }
CXItem >> collectionState: aString [
	"perfect, good, ,,,"
	
	collectionState := aString
]

{ #category : 'accessing' }
CXItem >> coverPictureName [
	^ coverPictureName

]

{ #category : 'accessing' }
CXItem >> coverPictureName: aValue [
	coverPictureName := aValue

]

{ #category : 'accessing' }
CXItem >> depotLegal [
	^ depotLegal

]

{ #category : 'accessing' }
CXItem >> depotLegal: aValue [
	depotLegal := aValue

]

{ #category : 'printing' }
CXItem >> displayStringOn: aStream [
	
	aStream nextPutAll: self title.
	aStream space ; print: self publicNumber; space.
	(self publicNumber = self numberOnCover) ifFalse: [ aStream print: self numberOnCover ; space ]. 
	self serie ifNotNil: [ aStream nextPutAll:  ' (',  serie title , ') ' ]
]

{ #category : 'accessing' }
CXItem >> editor [
	^ editor

]

{ #category : 'accessing' }
CXItem >> editor: aValue [
	editor := aValue

]

{ #category : 'accessing' }
CXItem >> entryCreationDate [
	^ entryCreationDate

]

{ #category : 'accessing' }
CXItem >> entryCreationDate: aValue [
	entryCreationDate := aValue

]

{ #category : 'accessing' }
CXItem >> entryNumber [
	^ entryNumber

]

{ #category : 'accessing' }
CXItem >> entryNumber: aValue [
	entryNumber := aValue

]

{ #category : 'accessing - composed' }
CXItem >> hasNumber [

	^ self publicNumber isNil not
]

{ #category : 'import from xml' }
CXItem >> importAuthors: aString [
	self authors: aString

]

{ #category : 'import from xml' }
CXItem >> importCastermanNote: aString [
	self castermanNote: aString
]

{ #category : 'import from xml' }
CXItem >> importCollection: aString [
	self collection: aString

]

{ #category : 'import from xml' }
CXItem >> importCoverPictureName: aString [
	self coverPictureName: aString

]

{ #category : 'import from xml' }
CXItem >> importDepotLegal: aDate [
	self depotLegal: aDate
]

{ #category : 'import from xml' }
CXItem >> importEditor: aString [
	self editor: aString

]

{ #category : 'accessing' }
CXItem >> importEntryCreationDate: aValue [
	self entryCreationDate: (Date readFromString: aValue)

]

{ #category : 'import from xml' }
CXItem >> importEntryNumber: anInteger [

	(anInteger isKindOf: Number)
		ifTrue: [ self entryNumber: anInteger ]
		ifFalse: [ self entryNumber: (Integer readFromString: anInteger) ]

]

{ #category : 'import from xml' }
CXItem >> importMainSerie: aString [
	self mainSerie: aString

]

{ #category : 'import from xml' }
CXItem >> importNotes: aValue [
	self notes: aValue asString

]

{ #category : 'import from xml' }
CXItem >> importNumber: anInteger [

	(anInteger isKindOf: Number)
		ifTrue: [ self number: anInteger ]
		ifFalse: [ self number: (Integer readFromString: anInteger) ]

]

{ #category : 'import from xml' }
CXItem >> importNumberOnCover: anInteger [

	(anInteger isKindOf: Number)
		ifTrue: [ self numberOnCover: anInteger ]
		ifFalse: [ self numberOnCover: (Integer readFromString: anInteger) ]

]

{ #category : 'import from xml' }
CXItem >> importOriginal: aValue [

	(aValue isKindOf: Boolean)
		ifTrue: [ self original: aValue ]
		ifFalse: [ self original: (Boolean readFromString: aValue) ]

]

{ #category : 'import from xml' }
CXItem >> importSerie: aValue [
	self serie: aValue

]

{ #category : 'import from xml' }
CXItem >> importSerieComplete: aValue [
	self serieComplete: (Object readFromString: aValue)

]

{ #category : 'import from xml' }
CXItem >> importSortedAs: aString [
	self sortedAs: aString asString

]

{ #category : 'import from xml' }
CXItem >> importTitle: aString [
	self title: aString asString

]

{ #category : 'import from xml' }
CXItem >> importYear: anInteger [

	(anInteger isKindOf: Year)
		ifTrue: [ self year: anInteger ]
		ifFalse: [ self year: (Integer readFromString: anInteger) ]

]

{ #category : 'testing' }
CXItem >> isSpeciallyNumbered [

	| num1 num2 | 
	num1 := self hasNumber 
		ifTrue: [ self publicNumber ] 
		ifFalse: [ 0 ].
	num2 := self sortedAs asNumber.
	^ ( num2 = num1 ) not
	
		
]

{ #category : 'accessing' }
CXItem >> lookingFor [

	collectionState := #lookingFor
]

{ #category : 'accessing' }
CXItem >> mainSerie [
	^ mainSerie

]

{ #category : 'accessing' }
CXItem >> mainSerie: aValue [
	mainSerie := aValue

]

{ #category : 'accessing' }
CXItem >> notes [
	^ notes

]

{ #category : 'accessing' }
CXItem >> notes: aValue [
	notes := aValue

]

{ #category : 'accessing' }
CXItem >> number [
	"Return the number of the book as in the serie.
	Usually this number is enough but some series such as potro minet the first album is numbered -99
	the second -98 and the fifth -84!"
	
	^ number

]

{ #category : 'accessing' }
CXItem >> number: aValue [
	number := aValue

]

{ #category : 'accessing' }
CXItem >> numberOnCover [
	
	^ numberOnCover

]

{ #category : 'accessing' }
CXItem >> numberOnCover: aValue [
	numberOnCover := aValue

]

{ #category : 'accessing' }
CXItem >> original [
	^ original

]

{ #category : 'accessing' }
CXItem >> original: aValue [
	original := aValue

]

{ #category : 'printing' }
CXItem >> printOn: aStream [
	
	| serieTitle |
	"to help debugging we make sure that a serie can be either a string or a serie object.
	This is handy to debug the wiring"
	
	aStream nextPutAll: self title.
	serieTitle := serie isString ifTrue: [ serie ] ifFalse: [ serie title ].
	self serie ifNotNil: [ aStream nextPutAll:  ' (', serieTitle , ') ' ]
]

{ #category : 'accessing - composed' }
CXItem >> publicNumber [
	"usually the public number is the number as element appearance in the serie
	other this is the numberOnCover. In case the number of cover is not known default to 0."
	
	^ number ifNil: [ self numberOnCover isNil ifTrue: [0] ifFalse: [ self numberOnCover ]]
	
]

{ #category : 'accessing' }
CXItem >> serializableInstanceVariables [

	^  #(#title #collectionState #notes #sortedAs #entryCreationDate #entryNumber #editor #year #mainSerie #serie #original #depotLegal #castermanNote #authors #ISBN #number #numberOnCover #serieComplete #coverPictureName #collection)
]

{ #category : 'accessing' }
CXItem >> serie [
	^ serie

]

{ #category : 'accessing' }
CXItem >> serie: aValue [
	serie := aValue

]

{ #category : 'accessing' }
CXItem >> serieComplete [
	^ serieComplete

]

{ #category : 'accessing' }
CXItem >> serieComplete: aValue [
	serieComplete := aValue

]

{ #category : 'accessing' }
CXItem >> serieTitle [
	
	^ serie title
]

{ #category : 'accessing' }
CXItem >> sortedAs [
	"An item is sorted within a serie as an explicit number, when there is a mess
	in the numbering or via its public number"
	
	"should be migrated to use numberAsOnCover"
	^ sortedAs ifNil: [ self publicNumber asString ]

]

{ #category : 'accessing' }
CXItem >> sortedAs: aValue [
	sortedAs := aValue asString

]

{ #category : 'accessing' }
CXItem >> title [
	^ title

]

{ #category : 'accessing' }
CXItem >> title: aValue [
	title := aValue asString

]

{ #category : 'accessing' }
CXItem >> year [
	^ year

]

{ #category : 'accessing' }
CXItem >> year: aValue [
	year := aValue

]
