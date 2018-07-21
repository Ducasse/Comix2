Class {
	#name : #MiniSeriePrinter,
	#superclass : #SeriePrinter,
	#category : #'Comix-Tools'
}

{ #category : #initialization }
MiniSeriePrinter >> initialize [ 

	super initialize.
	self fileName:  'MSeries'
]

{ #category : #printing }
MiniSeriePrinter >> printBD: aBD [

	aBD original 
		ifTrue: [
		stream 
			nextPutAll: ((aBD hasNumber) 
							ifTrue: [aBD publicNumber asString] 
							ifFalse: ['']); 
			nextPutAll: (aBD numberOnCover isNil not 
							ifTrue: [ '(', aBD numberOnCover asString, ')' ]
							ifFalse: ['']).
		stream space
			]
]

{ #category : #printing }
MiniSeriePrinter >> printSerie: each [

	each missingNumbers first isEmpty
		ifFalse: [
	stream nextPutAll: '\paragraph{' , each title asString.
	stream nextPutAll: ' (Ms:'.
	each missingNumbers first do: [:missing | stream nextPutAll: missing asString] 
		separatedBy: [stream nextPut: Character space].
	stream nextPutAll: ')' ; nextPutAll: '}' ; cr]
]
