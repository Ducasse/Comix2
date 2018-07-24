Class {
	#name : #CXBaseCollectionTest,
	#superclass : #CXFileTest,
	#instVars : [
		'collector'
	],
	#category : #'Comix-Model'
}

{ #category : #setup }
CXBaseCollectionTest >> setUp [

	super setUp.
	collector := CXCollector new
]

{ #category : #setup }
CXBaseCollectionTest >> testAddBase [
	| ownedBase |
	ownedBase := CXBase new.
	ownedBase kind: #owned.
	collector add: ownedBase.
	self assert: (collector baseNames includes: #owned)
]

{ #category : #setup }
CXBaseCollectionTest >> testBaseFor [
	| ownedBase |
	ownedBase := CXBase new.
	ownedBase kind: #owned.
	collector add: ownedBase.
	self assert: (collector baseFor: #owned) equals: ownedBase
]

{ #category : #setup }
CXBaseCollectionTest >> testBaseForError [

	self should: [ collector baseFor: #notdeclared ] raise: Error
]
