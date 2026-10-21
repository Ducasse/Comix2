"
I represent an author of albums. I am shared: the library registry guarantees a single instance per normalized name.
"
Class {
	#name : 'CBAuthor',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'CBComix',
	#package : 'CBComix'
}

{ #category : 'instance creation' }
CBAuthor class >> named: aString [

	^ self new
		  name: aString;
		  yourself
]

{ #category : 'printing' }
CBAuthor >> displayStringOn: aStream [

	aStream nextPutAll: name
]

{ #category : 'initialization' }
CBAuthor >> initialize [

	super initialize.
	name := ''
]

{ #category : 'accessing' }
CBAuthor >> name [

	^ name
]

{ #category : 'accessing' }
CBAuthor >> name: aString [

	name := aString
]

{ #category : 'printing' }
CBAuthor >> printOn: aStream [

	super printOn: aStream. 
	aStream 
		nextPutAll: ' (';
		nextPutAll: name;
		nextPutAll: ')'
]
