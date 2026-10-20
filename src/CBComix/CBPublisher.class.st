"
I represent a publisher (the editor attribute in the XML). I am shared through the library registry. A publisher with an empty name stands for an unknown publisher.
"
Class {
	#name : 'CBPublisher',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'CBComix',
	#package : 'CBComix'
}

{ #category : 'instance creation' }
CBPublisher class >> named: aString [

	^ self new
		  name: aString;
		  yourself
]

{ #category : 'initialization' }
CBPublisher >> initialize [

	super initialize.
	name := ''
]

{ #category : 'testing' }
CBPublisher >> isUnknown [

	^ name isEmpty
]

{ #category : 'accessing' }
CBPublisher >> name [

	^ name
]

{ #category : 'accessing' }
CBPublisher >> name: aString [

	name := aString
]

{ #category : 'printing' }
CBPublisher >> printOn: aStream [

	aStream nextPutAll: (self isUnknown
			 ifTrue: [ '<unknown publisher>' ]
			 ifFalse: [ name ])
]
