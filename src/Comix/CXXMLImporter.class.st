Class {
	#name : #CXXMLImporter,
	#superclass : #Object,
	#category : #Comix
}

{ #category : #importing }
CXXMLImporter class >> import [ 

	| p |
	p := XMLDOMParser onFileNamed: 'BD.319.xml'.
	p parseDocument
]
