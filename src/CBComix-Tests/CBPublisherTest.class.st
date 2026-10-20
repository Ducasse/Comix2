Class {
	#name : 'CBPublisherTest',
	#superclass : 'TestCase',
	#category : 'CBComix-Tests',
	#package : 'CBComix-Tests'
}

{ #category : 'tests' }
CBPublisherTest >> testIsUnknown [

	self assert: CBPublisher new isUnknown.
	self deny: (CBPublisher named: 'Dupuis') isUnknown
]

{ #category : 'tests' }
CBPublisherTest >> testNamed [

	self assert: (CBPublisher named: 'Dupuis') name equals: 'Dupuis'
]

{ #category : 'tests' }
CBPublisherTest >> testPrintOn [

	self assert: (CBPublisher named: 'Dupuis') printString equals: 'Dupuis'.
	self assert: CBPublisher new printString equals: '<unknown publisher>'
]
