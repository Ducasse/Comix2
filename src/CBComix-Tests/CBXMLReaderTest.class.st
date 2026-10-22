Class {
	#name : 'CBXMLReaderTest',
	#superclass : 'TestCase',
	#category : 'CBComix-Tests-ImportExport',
	#package : 'CBComix-Tests',
	#tag : 'ImportExport'
}

{ #category : 'tests' }
CBXMLReaderTest >> testElementsIn [

	| elements |
	elements := CBFlatManualXMLReader new elementsIn: '<?xml version="1.0"?>
<Base date="1 May 2010">
    <bd title="Gaston" number="9" />
    <wanted seriesName="Spirou"/>
</Base>'.
	self assert: (elements collect: [ :each | each key ]) asArray equals: #( 'Base' 'bd' 'wanted' ).
	self assert: (elements first value at: 'date') equals: '1 May 2010'.
	self assert: (elements second value at: 'title') equals: 'Gaston'.
	self assert: (elements second value at: 'number') equals: '9'.
	self assert: (elements third value at: 'seriesName') equals: 'Spirou'
]

{ #category : 'tests' }
CBXMLReaderTest >> testEmptyInput [

	self assert: (CBFlatManualXMLReader new elementsIn: '') isEmpty
]

{ #category : 'tests' }
CBXMLReaderTest >> testEncodeDecode [

	| text |
	text := 'a < b & "c" > d'.
	self assert: (CBFlatManualXMLReader encode: text) equals: 'a &lt; b &amp; &quot;c&quot; &gt; d'.
	self assert: (CBFlatManualXMLReader decode: (CBFlatManualXMLReader encode: text)) equals: text
]

{ #category : 'tests' }
CBXMLReaderTest >> testMultilineAndEntityValues [

	| attributes |
	attributes := (CBFlatManualXMLReader new elementsIn: '<bd title="Les mu
railles" notes="dit &quot;rare&quot; &amp; beau" />') first value.
	self 
		assert: (attributes at: 'title') 
		equals: 'Les mu
railles'.
	self 
		assert: (attributes at: 'notes') 
		equals: 'dit "rare" & beau'
]
