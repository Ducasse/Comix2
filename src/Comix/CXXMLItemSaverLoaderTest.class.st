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

{ #category : 'tests - basics' }
CXXMLItemSaverLoaderTest >> testVisitorXML [

	| vis base |
	vis := CXVisitor new. 
	base := CXBase new.
	base addSerie: CXItem nic serie. 
	base accept: vis. 
	self 
		assert: vis contents
		equals:   '<?xml version="1.0" encoding="UTF-8"?>
<Base date="24 January 2026" entriesNumber="2" note="nil">
<bd authors="Larcenet" editor="Dargaud" entryCreationDate="25 March 2006" entryNumber="1" number="1" original="true" serie="Serie  Nic oumouk" serieComplete="false" sortedAs="1" title="Total souk pour nic oumouk" year="2005"/>
<bd authors="Larcenet" editor="Dargaud" entryCreationDate="25 March 2007" entryNumber="1809" number="2" original="true" serie="Serie  Nic oumouk" serieComplete="false" sortedAs="2" title="La france a peur" year="2007"/></Base>'
		
]

{ #category : 'tests - basics' }
CXXMLItemSaverLoaderTest >> testVisitorXMLASingleEntry [

	| vis |
	vis := CXVisitor new. 
	CXItem nic serie bds first accept: vis. 
	self 
		assert: vis contents 
		equals: '<bd authors="Larcenet" editor="Dargaud" entryCreationDate="25 March 2006" entryNumber="1" number="1" original="true" serie="Serie  Nic oumouk" serieComplete="false" sortedAs="1" title="Total souk pour nic oumouk" year="2005"/>'



]

{ #category : 'tests - basics' }
CXXMLItemSaverLoaderTest >> testVisitorXMLASingleSerie [

	| vis |
	vis := CXVisitor new. 
	CXItem nic serie accept: vis. 
	self 
		assert: vis contents 
		equals: '<bd authors="Larcenet" editor="Dargaud" entryCreationDate="25 March 2006" entryNumber="1" number="1" original="true" serie="Serie  Nic oumouk" serieComplete="false" sortedAs="1" title="Total souk pour nic oumouk" year="2005"/>
<bd authors="Larcenet" editor="Dargaud" entryCreationDate="25 March 2007" entryNumber="1809" number="2" original="true" serie="Serie  Nic oumouk" serieComplete="false" sortedAs="2" title="La france a peur" year="2007"/>'



]

{ #category : 'helpers' }
CXXMLItemSaverLoaderTest >> xmlOriginalSample [

	^  self class xmlOriginalSample 
]
