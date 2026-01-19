Class {
	#name : 'CXXMLSaver',
	#superclass : 'Object',
	#instVars : [
		'directory',
		'items'
	],
	#category : 'Comix-Migration Support',
	#package : 'Comix',
	#tag : 'Migration Support'
}

{ #category : 'importing' }
CXXMLSaver >> save [
	"self new save"
	
	| vers |
	vers := NewFileVersionner from: directory.
	vers useBasenameNumberExtension. 
	^ self importFileName: (vers lastFileFor: 'BD' extension: 'xml') fullName
]

{ #category : 'importing' }
CXXMLSaver >> saveFileName: aString [
	"self new importFileName: 'NEWBD.322.xml'"
	
	| p |
	p := XMLWriter on: aString asFileReference writeStream.
	items do: [ :each | ].
	^ items
]
