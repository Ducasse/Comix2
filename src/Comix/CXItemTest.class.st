Class {
	#name : 'CXItemTest',
	#superclass : 'TestCase',
	#category : 'Comix-Tests',
	#package : 'Comix',
	#tag : 'Tests'
}

{ #category : 'tests' }
CXItemTest >> testBasicsAuthor [
	
	| nic |
	nic := CXItem nic.
	self assert: nic authors equals: 'Larcenet'.
	"should probably be a list of objects in the future."
]

{ #category : 'tests' }
CXItemTest >> testBasicsTitle [
	
	| nic |
	nic := CXItem nic.
	self assert: nic title equals: 'Total souk pour nic oumouk'.
	self assert: nic year equals: 2005.
	
]

{ #category : 'tests' }
CXItemTest >> testBelongsToSerie [

	| nic |
	nic := CXItem nic.
	self assert: nic serie title equals: 'Nic oumouk'.
	self 
		assert: (nic serie bds select: [ :each | each number = 1 ]) first title 
		equals: nic title.
]

{ #category : 'tests' }
CXItemTest >> testNumber [
	
	| nic |
	nic := CXItem nic.
	self assert: nic number equals: 1.
	self assert: nic publicNumber equals: 1.
	
	"if the numberOnCover is the same as the number just return the number."
	self assert: nic numberOnCover equals: 1.
	
]
