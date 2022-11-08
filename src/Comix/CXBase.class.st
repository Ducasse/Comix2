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
	#classInstVars : [
		'workingDirectory'
	],
	#category : #'Comix-Model'
}

{ #category : #'ston-core' }
CXBase class >> import: aFileName [

	
]

{ #category : #'ston-core' }
CXBase class >> load: filename [
	"self load: 'BDs'"

	| instance |
	instance := (self workingDirectory lastFileFor: filename extension: 'ston')
		asFileReference readStreamDo: [ :str | STON fromStream: str ].
	^ instance
	
]

{ #category : #'ston-core' }
CXBase class >> stefBase [
	<example>
	
	^ self new 
		workingDirectory: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/Comix' asFileReference ; 		yourself
]

{ #category : #'ston-core' }
CXBase class >> stonAllInstVarNames [
	^ self instanceVariables copyWithoutAll: self stonNotSerializedInstVarNames

]

{ #category : #'ston-core' }
CXBase class >> stonNotSerializedInstVarNames [
	^ {#workingDirectory}

]

{ #category : #'ston-core' }
CXBase class >> workingDirectory [

	^ workingDirectory ifNil: [ workingDirectory := FileSystem workingDirectory ]
]

{ #category : #'ston-core' }
CXBase class >> workingDirectory: aFileReference [
	workingDirectory := aFileReference
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

{ #category : #adding }
CXBase >> numberOfBDs [

	^ series inject: 0 into: [ :sum :each | sum + each numberOfBDs ]
			

]

{ #category : #iterations }
CXBase >> originalBdsDo: aBlock [

	self series do: [:aSerie | aSerie originalBdsDo: aBlock ]
]

{ #category : #io }
CXBase >> prepareModelToBeSaved [
	
	self series do: [:each | each rawBds: each bds asOrderedCollection ]
]

{ #category : #io }
CXBase >> restoreModel [
	
	self series do: [:each | each bds: each bds ]
]

{ #category : #io }
CXBase >> save [
	self prepareModelToBeSaved.
	(workingDirectory / (workingDirectory nextNameFor: 'BDs' extension: 'ston')) 
		asFileReference writeStreamDo: [ :str | str nextPutAll: 
		(STON toStringPretty: self)].
	self restoreModel.
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
		  sortBlock: self seriesSortBlock;
		  addAll: series values;
		  yourself
]

{ #category : #iterations }
CXBase >> seriesDo: aBlock [

	self series do: aBlock
]

{ #category : #adding }
CXBase >> seriesSortBlock [

	^ [ :a :b | a title < b title ]
]

{ #category : #accessing }
CXBase >> workingDirectory [

	^ workingDirectory
]

{ #category : #accessing }
CXBase >> workingDirectory: aFileReference [

	workingDirectory := aFileReference 
]
