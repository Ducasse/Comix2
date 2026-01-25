Class {
	#name : 'CXVisitor',
	#superclass : 'Object',
	#instVars : [
		'stream'
	],
	#category : 'Comix-Model',
	#package : 'Comix',
	#tag : 'Model'
}

{ #category : 'accessing' }
CXVisitor >> contents [

	^ stream contents
]

{ #category : 'initialization' }
CXVisitor >> initialize [

	super initialize.
	stream := WriteStream on: ''.
]

{ #category : 'visiting' }
CXVisitor >> visitBase: aBase [

	stream nextPutAll: 
	'<?xml version="1.0" encoding="UTF-8"?>
<Base date="', Date today asString, '" entriesNumber="', aBase numberOfBDs asString, '" note="nil">'.
	stream cr.
	aBase seriesDo: [ :each | each accept: self ].
	stream nextPutAll: '</Base>'
]

{ #category : 'visiting' }
CXVisitor >> visitItem: anItem [

	stream nextPutAll: anItem asXML
]

{ #category : 'visiting' }
CXVisitor >> visitSerie: aSerie [

	aSerie bds 
		do: [ :bd | bd accept: self ]
		separatedBy: [ stream cr ]
]
