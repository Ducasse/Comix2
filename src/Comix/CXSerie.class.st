Class {
	#name : 'CXSerie',
	#superclass : 'CXSeriable',
	#category : 'Comix-Model',
	#package : 'Comix',
	#tag : 'Model'
}

{ #category : 'missing' }
CXSerie >> missingNumberString [

	^ String streamContents: [ :str | 
			self missingNumbers first 
				do: [:missing | str nextPutAll: missing asString] 
				separatedBy: [str nextPut: Character space]]
]

{ #category : 'printing' }
CXSerie >> printOn: aStream [

	aStream << 'Serie '.
	aStream space.
	aStream << title
]
