Class {
	#name : #CXXMLImporter,
	#superclass : #Object,
	#category : #Comix
}

{ #category : #importing }
CXXMLImporter class >> compileSetterNamed: aName [

	BDItem 
		compile: (self setterBodyFor: aName)
		classified: 'accessing'
]

{ #category : #importing }
CXXMLImporter class >> import [ 

	| p base |
	base := BDBase new.
	p := XMLDOMParser onFileNamed: 'BD.319.xml'.
	p parseDocument elements first elements do: [ :each | 
		| bd | 
		bd := BDItem new.
		base add: bd. 
		each attributeNamesAndValuesDo: [ :attName :value | 
			[bd perform: attName with: value ] on: MessageNotUnderstood do: [ :ex | self compileSetterNamed: attName ]
			]
		]
]

{ #category : #importing }
CXXMLImporter class >> setterBodyFor: aName [

	^ (String streamContents: [:s |
						s << aName.
						s << ': aValue'.
						s cr.
						s tab.
						s << aName.
						s << ' := aValue'.
						s cr.
						])
	
]
