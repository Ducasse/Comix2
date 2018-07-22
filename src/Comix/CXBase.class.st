Class {
	#name : #CXBase,
	#superclass : #Object,
	#instVars : [
		'workingDirectory',
		'series'
	],
	#category : #'Comix-Model'
}

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

{ #category : #io }
CXBase >> load [
	"self new load"
	| base |
	base := (workingDirectory lastFileFor: 'BDs' extension: 'ston') 
		asFileReference readStreamDo: [ :str | (STON fromStream: str)].
	^ base
]

{ #category : #iterations }
CXBase >> originalBdsDo: aBlock [

	self series do: [:aSerie | aSerie originalBdsDo: aBlock ]
]

{ #category : #io }
CXBase >> save [

	(workingDirectory / (workingDirectory nextNameFor: 'BDs' extension: 'ston')) 
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
