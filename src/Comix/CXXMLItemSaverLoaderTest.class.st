Class {
	#name : 'CXXMLItemSaverLoaderTest',
	#superclass : 'TestCase',
	#category : 'Comix-Tests',
	#package : 'Comix',
	#tag : 'Tests'
}

{ #category : 'sample' }
CXXMLItemSaverLoaderTest class >> xmlOriginalSample [

	^  '<bd serieComplete="false" editor="Soleil" entryCreationDate="1 November 2008" entryNumber="2166" authors="Bec Raffaele" title="Le tunnel" serie="Pandemonium" original="true" number="2" year="2008" />'
]

{ #category : 'helpers' }
CXXMLItemSaverLoaderTest >> itemFromSpec [

	| item |
	item := CXItem new.
	#('serieComplete' 'editor' 'entryCreationDate' 'entryNumber' 'authors' 'title' 'serie' 'original' 'number' 'year') 
		with: #('false' 'Soleil' '1 November 2008' '2166' 'Bec Raffaele' 'Le tunnel' 'Pandemonium' 'true' '2' '2008')
		do: [ :m :v | item perform: (m, ':') asSymbol with: v ].
	^ item 
]

{ #category : 'tests - basics' }
CXXMLItemSaverLoaderTest >> testBasicGenerateXMLFromItem [

	self 
		assert: self itemFromSpec asXML  
		equals: '<bd authors="Bec Raffaele" editor="Soleil" entryCreationDate="1 November 2008" entryNumber="2166" number="2" original="true" serie="Pandemonium" serieComplete="false" sortedAs="2" title="Le tunnel" year="2008"/>'
	
]

{ #category : 'tests - basics' }
CXXMLItemSaverLoaderTest >> testBasicGenerateXMLFromSpec [

	| xmlW tag |
	xmlW := XMLWriter new.
	tag := xmlW tag: 'bd'.
	#('serieComplete' 'editor' 'entryCreationDate' 'entryNumber' 'authors' 'title' 'serie' 'original' 'number' 'year') 
		with: #('false' 'Soleil' '1 November 2008' '2166' 'Bec Raffaele' 'Le tunnel' 'Pandemonium' 'true' '2' '2008')
		do: [ :m :v |
			tag attributeAt: m put: v 
	]. 
	self assert: xmlW contents equals: '<bd serieComplete="false" editor="Soleil" entryCreationDate="1 November 2008" entryNumber="2166" authors="Bec Raffaele" title="Le tunnel" serie="Pandemonium" original="true" number="2" year="2008"/>'
]

{ #category : 'tests - basics' }
CXXMLItemSaverLoaderTest >> testReadXMLIn [

	| pxml bd |
	pxml := XMLDOMParser on: self xmlOriginalSample.
	bd := pxml parseDocument elements first. 
	self assert: bd attributes keys equals: #('serieComplete' 'editor' 'entryCreationDate' 'entryNumber' 'authors' 'title' 'serie' 'original' 'number' 'year').
	self assert: bd attributes values equals: #('false' 'Soleil' '1 November 2008' '2166' 'Bec Raffaele' 'Le tunnel' 'Pandemonium' 'true' '2' '2008') 
]

{ #category : 'helpers' }
CXXMLItemSaverLoaderTest >> xmlOriginalSample [

	^  self class xmlOriginalSample 
]
