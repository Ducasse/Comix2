Class {
	#name : 'ComicSeries',
	#superclass : 'ComicNode',
	#instVars : [
		'name',
		'volumes'
	],
	#category : 'ComicBooks-Core',
	#package : 'ComicBooks',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ComicSeries class >> name: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : 'accessing' }
ComicSeries >> addChild: aComicBook [
	volumes add: aComicBook
]

{ #category : 'accessing' }
ComicSeries >> children [
	^ volumes
]

{ #category : 'accessing' }
ComicSeries >> displayName [
	^ name
]

{ #category : 'initialization' }
ComicSeries >> initialize [
	volumes := OrderedCollection new
]

{ #category : 'testing' }
ComicSeries >> isLeaf [
	^ false
]

{ #category : 'accessing' }
ComicSeries >> name [
	^ name
]

{ #category : 'accessing' }
ComicSeries >> name: aString [
	name := aString
]

{ #category : 'printing' }
ComicSeries >> printOn: aStream [
	aStream nextPutAll: name
]
