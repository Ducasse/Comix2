"
I'm a collection of series. For example the owned comix. I could also be the collection of lent ones. 


	(CXBase new addNewSerieFromCollection: CXXMLImporter new import) save
	will generate a ston file containing all the objects from the XML  old file format. 
	

"
Class {
	#name : #CXBase,
	#superclass : #Object,
	#instVars : [
		'workingDirectory',
		'series',
		'kind'
	],
	#category : #'Comix-Model'
}

{ #category : #'ston-core' }
CXBase class >> stonAllInstVarNames [
	^ self instanceVariables copyWithoutAll: self stonNotSerializedInstVarNames

]

{ #category : #'ston-core' }
CXBase class >> stonNotSerializedInstVarNames [
	^ {#workingDirectory}

]

{ #category : #adding }
CXBase >> addNewSerieFromCollection: bds [
	"bds is a collection of unconnected bds objects. It means that their series are not object but string"
	| newSeries |
	newSeries := bds groupedBy: [ :each | each serie ].
	newSeries keysAndValuesDo: [ :k :v | self addSerie: 
													(CXSerie new 
														sortedAs: k;
														title: v first serie;
														bds: v)
														]
	
		
]

{ #category : #adding }
CXBase >> addSerie: aSerie [

	series at: aSerie sortedAs put: aSerie 
]

{ #category : #iterations }
CXBase >> bdsDo: aBlock [

	self series do: [:aSerie | aSerie bdsDo: aBlock ]
]

{ #category : #iterations }
CXBase >> bdsSortedBySeries [

	| ord |
	ord := OrderedCollection new.
	self originalBdsDo: [ :each | ord add: each ].
	^ ord
]

{ #category : #initialization }
CXBase >> initialize [

	super initialize.
	series := Dictionary new. 
	workingDirectory := FileSystem workingDirectory.
]

{ #category : #accessing }
CXBase >> kind [
	^ kind
]

{ #category : #accessing }
CXBase >> kind: aSymbol [
	"Indicates the kind of collection for example own, to sell, or lookedup"
	kind := aSymbol
]

{ #category : #io }
CXBase >> load [
	"self new load"

	| base |
	base := (workingDirectory lastFileFor: 'BDs' extension: 'ston') asFileReference
					readStreamDo: [ :str | STON fromStream: str ].
	^ base
]

{ #category : #iterations }
CXBase >> originalBdsDo: aBlock [

	self series do: [:aSerie | aSerie originalBdsDo: aBlock ]
]

{ #category : #io }
CXBase >> save [
	| name |
	name := kind isNil.
	(workingDirectory / (workingDirectory nextNameFor: 'BDs' extension: 'ston')) 
		asFileReference writeStreamDo: [ :str | str nextPutAll: 
		(STON toStringPretty: self)]
]

{ #category : #io }
CXBase >> saveKind [
	| name |
	name := kind ifNotNil: [:akind | 'BDs', akind asString ] ifNil: [ 'BDs'].
	(workingDirectory / (workingDirectory nextNameFor: name extension: 'ston')) 
		asFileReference writeStreamDo: [ :str | str nextPutAll: 
		(STON toStringPretty: self)]
]

{ #category : #accessing }
CXBase >> serieNamed: aTitle [

	^ series at: aTitle ifAbsent: [ self error: 'There is no serie named ', aTitle ]
]

{ #category : #adding }
CXBase >> series [

	^ SortedCollection new 
			sortBlock: [:a :b | a title < b title]; 
			addAll: series values; 
			yourself
			

]

{ #category : #iterations }
CXBase >> seriesDo: aBlock [

	self series do: aBlock
]
