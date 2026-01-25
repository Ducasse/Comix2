"
I'm a collection of series. For example the owned comix. I could also be the collection of lent ones. 

```
(CXBase new addNewSerieFromCollection: CXXMLImporter new import).

(CXBase stefBase addNewSerieFromCollection: CXXMLImporter stefBds)
```
will generate a ston file containing all the objects from the XML  old file format. 
	

"
Class {
	#name : 'CXBase',
	#superclass : 'Object',
	#instVars : [
		'workingDirectory',
		'series',
		'kind'
	],
	#classInstVars : [
		'workingDirectory'
	],
	#category : 'Comix-Model',
	#package : 'Comix',
	#tag : 'Model'
}

{ #category : 'ston-core' }
CXBase class >> load: filename [
	"self load: 'BDs'"

	| instance |
	self flag: #doNotUseYet.
	"should write more tests on saving collection in Ston."
	instance := (self workingDirectory lastFileFor: filename extension: 'ston')
		asFileReference readStreamDo: [ :str | STON fromStream: str ].
	^ instance
	
]

{ #category : 'ston-core' }
CXBase class >> stefBase [
	<script>
	
	^ self new 
		workingDirectory: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/Comix' asFileReference ; 	
		inspect; 
		yourself
]

{ #category : 'ston-core' }
CXBase class >> stonAllInstVarNames [

	^ self instVarNames copyWithoutAll: self stonNotSerializedInstVarNames

]

{ #category : 'ston-core' }
CXBase class >> stonNotSerializedInstVarNames [
	^ {#workingDirectory}

]

{ #category : 'ston-core' }
CXBase class >> workingDirectory [

	^ workingDirectory ifNil: [ workingDirectory := FileSystem workingDirectory ]
]

{ #category : 'ston-core' }
CXBase class >> workingDirectory: aFileReference [
	workingDirectory := aFileReference
]

{ #category : 'visiting' }
CXBase >> accept: aVisitor [

	aVisitor visitBase: self
]

{ #category : 'private for importing' }
CXBase >> addNewSeriesFromCollection: bds [
	"bds is a collection of unconnected bds objects. It means that their series are not object but string"
	
	| newSeries |
	newSeries := bds groupedBy: [ :each | each serie ].
	newSeries keysAndValuesDo: [ :k :v | 
		| aSerie |
		aSerie := (CXSerie new 
						sortedAs: k;
						title: v first serie;
						bds: v).
														
		self addSerie: aSerie.
		v do: [ :aBD | aBD serie: aSerie ] ]
	
		
]

{ #category : 'adding' }
CXBase >> addSerie: aSerie [

	series at: aSerie sortedAs put: aSerie 
]

{ #category : 'iterations' }
CXBase >> bdsDo: aBlock [

	self series do: [:aSerie | aSerie bdsDo: aBlock ]
]

{ #category : 'iterations' }
CXBase >> bdsSortedBySeries [

	| ord |
	ord := OrderedCollection new.
	self originalBdsDo: [ :each | ord add: each ].
	^ ord
]

{ #category : 'initialization' }
CXBase >> initialize [

	super initialize.
	series := Dictionary new. 
	workingDirectory := FileSystem workingDirectory.
]

{ #category : 'accessing' }
CXBase >> kind [
	"Return the status of a base, e.g., owned, lookingFor, lent"
	
	^ kind
]

{ #category : 'accessing' }
CXBase >> kind: aSymbol [
	"Indicates the kind of collection for example own, to sell, or lookedup
	Pay attention that it will be used to save file"
	
	kind := aSymbol
]

{ #category : 'io' }
CXBase >> load [
	"self new load"
	"this shows that there is something wrong a base cannot load itself.
	It should be on the class side, then the working directory probably too. 
	So all the API sucks!"
	self flag: #comeBack.
	^ self loadFromFileReference:  (workingDirectory lastFileFor: 'BDs' extension: 'ston') asFileReference
	
]

{ #category : 'io' }
CXBase >> loadFromFileReference: aFileReference [
	"self new load"
	self flag: #comeBack. 
	"this creates a new instance so the logic is absurd or/and buggy"
	^ aFileReference asFileReference readStreamDo: [ :str | STON fromStream: str ].

]

{ #category : 'adding' }
CXBase >> numberOfBDs [

	^ series inject: 0 into: [ :sum :each | sum + each numberOfBDs ]
			

]

{ #category : 'iterations' }
CXBase >> originalBdsDo: aBlock [
	"Original bds refers to the fact that this is not a reedition."
	self series do: [ :aSerie | aSerie originalBdsDo: aBlock ]
]

{ #category : 'io' }
CXBase >> prepareModelToBeSaved [
	
	self series do: [:each | each rawBds: each bds asOrderedCollection ]
]

{ #category : 'io' }
CXBase >> restoreModel [
	
	self series do: [:each | each bds: each bds ]
]

{ #category : 'io' }
CXBase >> save [
	self flag: ##comeBack. 
	"Strange ut does not use the kind so it looks infinished"
	self saveOnFileReference: (workingDirectory / (workingDirectory nextNameFor: 'BDs' extension: 'ston')) 
]

{ #category : 'io' }
CXBase >> saveKind [
	| name |
	self flag: #comeBack. 
	"check save and keep only one.
	The save should include the kind because we should have 
	only one list of lookingFor and one for we have.
	
	"
	name := kind ifNotNil: [:akind | 'BDs', akind asString ] ifNil: [ 'BDs'].
	(workingDirectory / (workingDirectory nextNameFor: name extension: 'ston')) 
		asFileReference writeStreamDo: [ :str | str nextPutAll: 
		(STON toStringPretty: self)]
]

{ #category : 'io' }
CXBase >> saveOnFileReference: aFileReference [
	self prepareModelToBeSaved.
	aFileReference asFileReference 
		writeStreamDo: [ :str | str nextPutAll: (STON toStringPretty: self)].
	self restoreModel.
]

{ #category : 'accessing' }
CXBase >> serieNamed: aTitle [

	^ series at: aTitle ifAbsent: [ self error: 'There is no serie named ', aTitle ]
]

{ #category : 'adding' }
CXBase >> series [

	^ SortedCollection new
		  sortBlock: self seriesSortBlock;
		  addAll: series values;
		  yourself
]

{ #category : 'iterations' }
CXBase >> seriesDo: aBlock [

	self series do: aBlock
]

{ #category : 'adding' }
CXBase >> seriesSortBlock [

	^ [ :a :b | a title < b title ]
]

{ #category : 'accessing' }
CXBase >> workingDirectory [

	^ workingDirectory
]

{ #category : 'accessing' }
CXBase >> workingDirectory: aFileReference [

	workingDirectory := aFileReference 
]
