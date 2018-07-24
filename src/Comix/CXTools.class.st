Class {
	#name : #CXTools,
	#superclass : #Object,
	#instVars : [
		'base'
	],
	#category : #'Comix-Tools'
}

{ #category : #visiting }
CXTools >> doBase [
	base seriesDo: [ :aSerie | self visitSerie: aSerie ]
]

{ #category : #visiting }
CXTools >> doSerie: aSerie [
	aSerie originalBdsDo: [ :each | self visitItem: each ]
]

{ #category : #visiting }
CXTools >> postBase [
	
]

{ #category : #visiting }
CXTools >> postSerie: aSerie [

]

{ #category : #visiting }
CXTools >> preBase [
	
]

{ #category : #visiting }
CXTools >> preSerie: aSerie [

]

{ #category : #accessing }
CXTools >> setBase: aBase [

	base := aBase 
]

{ #category : #visiting }
CXTools >> visitBase [
	"visit all series and comics even those that are not originals."

	self preBase.
	self doBase.
	self postBase
]

{ #category : #visiting }
CXTools >> visitItem: anItem [
]

{ #category : #visiting }
CXTools >> visitSerie: aSerie [
	self preSerie: aSerie.
	"here we may have a problem if we have a unique item not original in the serie.
	such as ann de la jungle."
	self doSerie: aSerie.
	self postSerie: aSerie
]
