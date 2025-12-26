Class {
	#name : 'CXCollectorTest',
	#superclass : 'CXFileTest',
	#instVars : [
		'collector'
	],
	#category : 'Comix-Tests',
	#package : 'Comix',
	#tag : 'Tests'
}

{ #category : 'setup' }
CXCollectorTest >> setUp [

	super setUp.
	collector := CXCollector new
]

{ #category : 'setup' }
CXCollectorTest >> testAddBase [
	| ownedBase |
	ownedBase := CXBase new.
	ownedBase kind: #owned.
	collector add: ownedBase.
	self assert: (collector baseNames includes: #owned)
]

{ #category : 'setup' }
CXCollectorTest >> testBaseFor [
	| ownedBase |
	ownedBase := CXBase new.
	ownedBase kind: #owned.
	collector add: ownedBase.
	self assert: (collector baseFor: #owned) equals: ownedBase
]

{ #category : 'setup' }
CXCollectorTest >> testBaseForError [

	self should: [ collector baseFor: #notdeclared ] raise: Error
]
