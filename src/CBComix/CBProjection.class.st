"
I am a view on another album container (the owned collection or another projection).
My albums are computed from my source with my rule each time, so they are the very same album objects and always in sync.
"
Class {
	#name : 'CBProjection',
	#superclass : 'CBAlbumContainer',
	#instVars : [
		'source',
		'rule'
	],
	#category : 'CBComix-Core',
	#package : 'CBComix',
	#tag : 'Core'
}

{ #category : 'instance creation' }
CBProjection class >> named: aString on: aContainer rule: aBlock [

	^ self new
		  name: aString;
		  source: aContainer;
		  rule: aBlock;
		  yourself
]

{ #category : 'accessing' }
CBProjection >> albums [

	^ source select: rule
]

{ #category : 'initialization' }
CBProjection >> initialize [

	super initialize.
	source := CBBookCollection new.
	rule := [ :album | true ]
]

{ #category : 'accessing' }
CBProjection >> rule [

	^ rule
]

{ #category : 'accessing' }
CBProjection >> rule: aBlock [

	rule := aBlock
]

{ #category : 'accessing' }
CBProjection >> source [

	^ source
]

{ #category : 'accessing' }
CBProjection >> source: aContainer [

	source := aContainer
]
