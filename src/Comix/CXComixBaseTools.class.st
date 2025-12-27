Class {
	#name : 'CXComixBaseTools',
	#superclass : 'CXTools',
	#instVars : [
		'base'
	],
	#category : 'Comix-Tools',
	#package : 'Comix',
	#tag : 'Tools'
}

{ #category : 'visiting' }
CXComixBaseTools >> doBase [

	base seriesDo: [ :aSerie | self visitSerie: aSerie ]
]

{ #category : 'visiting' }
CXComixBaseTools >> doSerie: aSerie [
	aSerie originalBdsDo: [ :each | self visitItem: each ]
]

{ #category : 'visiting' }
CXComixBaseTools >> postBase [
	
]

{ #category : 'visiting' }
CXComixBaseTools >> postSerie: aSerie [

]

{ #category : 'visiting' }
CXComixBaseTools >> preBase [
	
]

{ #category : 'visiting' }
CXComixBaseTools >> preSerie: aSerie [

]

{ #category : 'accessing' }
CXComixBaseTools >> setBase: aBase [

	base := aBase 
]

{ #category : 'visiting' }
CXComixBaseTools >> visitBase [
	"visit all series and comics even those that are not originals."

	self preBase.
	self doBase.
	self postBase
]

{ #category : 'visiting' }
CXComixBaseTools >> visitItem: anItem [
]

{ #category : 'visiting' }
CXComixBaseTools >> visitSerie: aSerie [
	self preSerie: aSerie.
	"here we may have a problem if we have a unique item not original in the serie.
	such as ann de la jungle."
	self doSerie: aSerie.
	self postSerie: aSerie
]
