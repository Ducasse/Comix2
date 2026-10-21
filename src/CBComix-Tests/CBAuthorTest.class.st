Class {
	#name : 'CBAuthorTest',
	#superclass : 'TestCase',
	#category : 'CBComix-Tests',
	#package : 'CBComix-Tests'
}

{ #category : 'tests' }
CBAuthorTest >> testDefaultNameIsEmpty [

	self assert: CBAuthor new name isEmpty
]

{ #category : 'tests' }
CBAuthorTest >> testNamed [

	self assert: (CBAuthor named: 'Franquin') name equals: 'Franquin'
]

{ #category : 'tests' }
CBAuthorTest >> testPrintOn [

	self 
		assert: (CBAuthor named: 'Franquin') printString 
		equals: 'a CBAuthor (Franquin)'
]
