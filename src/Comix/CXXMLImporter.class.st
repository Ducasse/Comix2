Class {
	#name : #CXXMLImporter,
	#superclass : #Object,
	#category : #'Comix-Migration Support'
}

{ #category : #importing }
CXXMLImporter class >> compileAccessorsNamed: aName [
	Transcript show: aName.
	CXItem 
		compile: (self setterBodyFor: aName)
		classified: 'accessing'.
	CXItem 
		compile: (self getterBodyFor: aName)
		classified: 'accessing'.	
	
]

{ #category : #importing }
CXXMLImporter class >> compileSetterNamed: aName [

	CXItem 
		compile: (self setterBodyFor: aName)
		classified: 'accessing'
]

{ #category : #importing }
CXXMLImporter class >> getterBodyFor: aName [

	^ (String streamContents: [:s |
						s << aName.
						s cr.
						s tab.
						s << '^ ' << aName.
						s cr.
						])
	
]

{ #category : #importing }
CXXMLImporter class >> import [ 
	"self import"
	| p col |
	col := OrderedCollection new.
	p := XMLDOMParser onFileNamed: 'BD.319.xml'.
	p parseDocument elements first elements do: [ :each | 
		| bd | 
		bd := CXItem new.
		col add: bd.
		each attributeNamesAndValuesDo: [ :attName :value | 
			bd perform: (attName, ':') asSymbol with: value
			"[ bd perform: attName with: value ] 
					on: MessageNotUnderstood 
					do: [ :ex | self compileAccessorsNamed: attName ]" ]
		].
	^ col
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
