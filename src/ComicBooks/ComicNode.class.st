Class {
	#name : 'ComicNode',
	#superclass : 'Object',
	#category : 'ComicBooks-Core',
	#package : 'ComicBooks',
	#tag : 'Core'
}

{ #category : 'accessing' }
ComicNode >> addChild: aComicBook [
	self shouldNotImplement
]

{ #category : 'accessing' }
ComicNode >> children [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
ComicNode >> displayName [
	^ self subclassResponsibility
]

{ #category : 'testing' }
ComicNode >> isLeaf [
	^ self subclassResponsibility
]
