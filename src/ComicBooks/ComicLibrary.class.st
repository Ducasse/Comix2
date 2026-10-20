Class {
	#name : 'ComicLibrary',
	#superclass : 'Object',
	#instVars : [
		'nodes'
	],
	#category : 'ComicBooks-Core',
	#package : 'ComicBooks',
	#tag : 'Core'
}

{ #category : 'accessing' }
ComicLibrary >> addLooseBook: aComicBook [
	nodes add: aComicBook
]

{ #category : 'accessing' }
ComicLibrary >> addNode: aComicNode [
	nodes add: aComicNode
]

{ #category : 'accessing' }
ComicLibrary >> addSeries: aComicSeries [
	nodes add: aComicSeries
]

{ #category : 'initialization' }
ComicLibrary >> initialize [
	nodes := OrderedCollection new
]

{ #category : 'accessing' }
ComicLibrary >> looseBooks [
	^ nodes select: [ :n | n isKindOf: ComicBook ]
]

{ #category : 'accessing' }
ComicLibrary >> nodes [
	^ nodes
]

{ #category : 'accessing' }
ComicLibrary >> series [
	^ nodes select: [ :n | n isKindOf: ComicSeries ]
]
