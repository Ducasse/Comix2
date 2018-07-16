Class {
	#name : #SeriePrinter,
	#superclass : #LatexPrinter,
	#category : #'Comix-Tools'
}

{ #category : #printing }
SeriePrinter class >> printBaseName: aSymbol [

	| fx |
	fx := CXBase baseNamed: aSymbol asSymbol.
	(self new base: fx) save
]

{ #category : #latex }
SeriePrinter >> addTableStart [ 

	stream cr ; nextPutAll: '\noindent\begin{tabular}{|rp{5cm}r|}\hline' ; cr

]

{ #category : #latex }
SeriePrinter >> columns [

	^ 'twocolumn'
]

{ #category : #initialize }
SeriePrinter >> initialize [

	super initialize.
	self fileName:  'Series'
]

{ #category : #initialize }
SeriePrinter >> printBD: aBD [ 

	aBD isOriginal 
		ifTrue: [
		stream cr; 
			nextPutAll: ((aBD hasNumber) 
							ifTrue: [aBD publicNumber asString] 
							ifFalse: ['']); 
			nextPutAll: (aBD numberOnCover isNil not 
							ifTrue: [ '(', aBD numberOnCover asString, ')' ]
							ifFalse: ['']);
			nextPutAll: '&' ; 
			nextPutAll: aBD title asString ; nextPutAll: '&' ; 
			nextPutAll: aBD year asString.
			self hline]
]

{ #category : #initialize }
SeriePrinter >> printBDs: aSortedCollection [

	self addTableStart.
	aSortedCollection do: [:each | self printBD: each.].
	self addTableEnd
]

{ #category : #initialize }
SeriePrinter >> treatBase [
	"self printNormal"

	base series do: [ :each | 
						self printSerie: each. stream cr.
						self printBDs: each bds]

	
]
