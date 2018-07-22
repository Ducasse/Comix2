Class {
	#name : #CXTools,
	#superclass : #Object,
	#instVars : [
		'base'
	],
	#category : #'Comix-Tools'
}

{ #category : #initialization }
CXTools >> setBase: aBase [

	base := aBase 
]

{ #category : #initialization }
CXTools >> visitBase [

	base seriesDo: [ :aSerie | self visitSerie: aSerie ]
]

{ #category : #initialization }
CXTools >> visitItem: anItem [
]

{ #category : #initialization }
CXTools >> visitSerie: aSerie [
]
