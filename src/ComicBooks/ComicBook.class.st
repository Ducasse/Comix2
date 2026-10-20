Class {
	#name : 'ComicBook',
	#superclass : 'ComicNode',
	#instVars : [
		'title',
		'author',
		'volumeNumber'
	],
	#category : 'ComicBooks-Core',
	#package : 'ComicBooks',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ComicBook class >> title: aTitle author: anAuthor [
	^ self new
		title: aTitle;
		author: anAuthor;
		yourself
]

{ #category : 'instance creation' }
ComicBook class >> title: aTitle author: anAuthor volumeNumber: anInteger [
	^ self new
		title: aTitle;
		author: anAuthor;
		volumeNumber: anInteger;
		yourself
]

{ #category : 'accessing' }
ComicBook >> author [
	^ author
]

{ #category : 'accessing' }
ComicBook >> author: aString [
	author := aString
]

{ #category : 'accessing' }
ComicBook >> children [
	^ #()
]

{ #category : 'accessing' }
ComicBook >> displayName [
	^ volumeNumber
		ifNil: [ title ]
		ifNotNil: [ volumeNumber printString , '. ' , title ]
]

{ #category : 'testing' }
ComicBook >> isLeaf [
	^ true
]

{ #category : 'printing' }
ComicBook >> printOn: aStream [
	aStream
		nextPutAll: title;
		nextPutAll: ' by ';
		nextPutAll: author
]

{ #category : 'accessing' }
ComicBook >> title [
	^ title
]

{ #category : 'accessing' }
ComicBook >> title: aString [
	title := aString
]

{ #category : 'accessing' }
ComicBook >> volumeNumber [
	^ volumeNumber
]

{ #category : 'accessing' }
ComicBook >> volumeNumber: anInteger [
	volumeNumber := anInteger
]
