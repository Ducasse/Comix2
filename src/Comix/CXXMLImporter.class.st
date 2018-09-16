"
A simple importer from my old format. 
Used in comments of other classes.
"
Class {
	#name : #CXXMLImporter,
	#superclass : #Object,
	#instVars : [
		'workingDirectory'
	],
	#category : #'Comix-Migration Support'
}

{ #category : #utils }
CXXMLImporter >> compileAccessorsNamed: aName [
	CXItem 
		compile: (self setterBodyFor: aName)
		classified: 'accessing'.
	CXItem 
		compile: (self getterBodyFor: aName)
		classified: 'accessing'.	
	
]

{ #category : #utils }
CXXMLImporter >> compileSetterNamed: aName [

	CXItem 
		compile: (self setterBodyFor: aName)
		classified: 'accessing'
]

{ #category : #utils }
CXXMLImporter >> getterBodyFor: aName [

	^ (String streamContents: [:s |
						s << aName.
						s cr.
						s tab.
						s << '^ ' << aName.
						s cr.
						])
	
]

{ #category : #importing }
CXXMLImporter >> import [
	"self new import"

	^ self importFileName: (self workingDirectory lastFileFor: 'BD' extension: 'xml') fullName
]

{ #category : #importing }
CXXMLImporter >> importFileName: aString [
	"self new importFileName: 'BD.322.xml'"
	| p col |
	col := OrderedCollection new.
	p := XMLDOMParser onFileNamed: aString.
	p parseDocument elements first elements do: [ :each | 
		| bd | 
		bd := CXItem new.
		col add: bd.
		each attributeNamesAndValuesDo: [ :attName :value | 
			bd perform: ('import', attName capitalized , ':') asSymbol with: value
			"[ bd perform: attName with: value ] 
					on: MessageNotUnderstood 
					do: [ :ex | self compileAccessorsNamed: attName ]" ]
		].
	^ col
]

{ #category : #initialization }
CXXMLImporter >> initialize [ 
	super initialize.
	workingDirectory := FileSystem workingDirectory
]

{ #category : #utils }
CXXMLImporter >> setterBodyFor: aName [

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

{ #category : #accessing }
CXXMLImporter >> workingDirectory [

	^ workingDirectory
]

{ #category : #accessing }
CXXMLImporter >> workingDirectory: aFileReference [

	workingDirectory := aFileReference
]
