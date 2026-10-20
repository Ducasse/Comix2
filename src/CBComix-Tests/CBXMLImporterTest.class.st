Class {
	#name : 'CBXMLImporterTest',
	#superclass : 'TestCase',
	#instVars : [
		'library',
		'importer'
	],
	#category : 'CBComix-Tests',
	#package : 'CBComix-Tests'
}

{ #category : 'running' }
CBXMLImporterTest >> setUp [

	super setUp.
	library := CBLibrary new.
	importer := CBXMLImporter on: library
]

{ #category : 'tests' }
CBXMLImporterTest >> testAuthorNamesFormat2KeepsSpaces [

	importer importBase: (Dictionary new
			 at: 'format' put: '2';
			 yourself).
	self assert: importer format equals: '2'.
	self assert: (importer authorNamesFrom: 'Van Hamme and Rosinski') asArray equals: #( 'Van Hamme' 'Rosinski' )
]

{ #category : 'tests' }
CBXMLImporterTest >> testAuthorNamesHistoricalFormat [

	self assert: (importer authorNamesFrom: 'Tome Janry') asArray equals: #( 'Tome' 'Janry' ).
	self
		assert: (importer authorNamesFrom: 'Abouet, Marguerite and Mary, Donatien') asArray
		equals: #( 'Abouet, Marguerite' 'Mary, Donatien' ).
	self assert: (importer authorNamesFrom: '') isEmpty
]

{ #category : 'tests' }
CBXMLImporterTest >> testDateFrom [

	self assert: (importer dateFrom: '25 March 2006') equals: (Date year: 2006 month: 3 day: 25).
	self assert: (importer dateFrom: '') equals: Date today
]

{ #category : 'tests' }
CBXMLImporterTest >> testImportHistoricalEntry [

	| album |
	importer importString: '<Base date="31 October 2010">
<bd serieComplete="false" editor="Dargaud" entryCreationDate="5 May 2006" entryNumber="2" authors="Greg" title="Les petits desseins d''Achille Talon" serie="Achille Talon" original="true" notes="4eme de couv" number="9" year="1974" />
</Base>'.
	album := library owned albums first.
	self assert: album title equals: 'Les petits desseins d''Achille Talon'.
	self assert: album series identicalTo: (library seriesNamed: 'Achille Talon').
	self assert: (album series albums includes: album).
	self assert: album publisher identicalTo: (library publisherNamed: 'Dargaud').
	self assert: (album authors collect: [ :each | each name ]) asArray equals: #( 'Greg' ).
	self assert: album number equals: 9.
	self assert: album year equals: 1974.
	self assert: album entryNumber equals: 2.
	self assert: album entryDate equals: (Date year: 2006 month: 5 day: 5).
	self assert: album isOriginal.
	self assert: album notes equals: '4eme de couv'.
	self deny: album series isComplete
]

{ #category : 'tests' }
CBXMLImporterTest >> testImportRealCollection [

	| file |
	file := FileLocator imageDirectory / 'BD.362.xml'.
	file exists ifFalse: [ ^ self skip ].
	importer importFile: file.
	self assert: library owned size equals: 3352.
	self assert: (library owned albums allSatisfy: [ :each | each series albums includes: each ])
]

{ #category : 'tests' }
CBXMLImporterTest >> testImportWanted [

	| wanted |
	importer importString: '<wanted seriesName="Gaston" number="10" title="Le cas Lagaffe" notes="max 20" />'.
	self assert: library owned isEmpty.
	wanted := library wanted entries first.
	self assert: wanted seriesName equals: 'Gaston'.
	self assert: wanted number equals: 10.
	self assert: wanted title equals: 'Le cas Lagaffe'.
	self assert: wanted notes equals: 'max 20'
]

{ #category : 'tests' }
CBXMLImporterTest >> testIntegerFrom [

	self assert: (importer integerFrom: '12') equals: 12.
	self assert: (importer integerFrom: '-1') equals: 0.
	self assert: (importer integerFrom: '') equals: 0.
	self assert: (importer integerFrom: '3bis') equals: 0
]

{ #category : 'tests' }
CBXMLImporterTest >> testMissingAttributesUseDefaults [

	| album |
	importer importString: '<bd serie="Gaston" />'.
	album := library owned albums first.
	self assert: album title isEmpty.
	self deny: album hasNumber.
	self deny: album hasYear.
	self assert: album publisher isUnknown.
	self assert: album authors isEmpty
]

{ #category : 'tests' }
CBXMLImporterTest >> testSerieCompleteWhenAnyEntrySaysSo [

	importer importString: '<bd serie="Gaston" serieComplete="true" />
<bd serie="Gaston" serieComplete="false" />'.
	self assert: (library seriesNamed: 'Gaston') isComplete
]

{ #category : 'tests' }
CBXMLImporterTest >> testSharedObjectsAcrossEntries [

	importer importString: '<bd serie="Gaston" editor="Dupuis" authors="Franquin" number="9" />
<bd serie="gaston" editor="Dupuis" authors="Franquin" number="10" />'.
	self assert: library allSeries size equals: 1.
	self assert: library allPublishers size equals: 1.
	self assert: library allAuthors size equals: 1.
	self assert: (library seriesNamed: 'Gaston') albums size equals: 2
]

{ #category : 'tests' }
CBXMLImporterTest >> testTagsAndProjections [

	importer importString: '<bd serie="Gaston" tags="belgian humor" />'.
	self assert: ((library seriesNamed: 'Gaston') hasTag: #humor).
	self assert: (library projectionNamed: #belgian) size equals: 1
]

{ #category : 'tests' }
CBXMLImporterTest >> testUnknownElementsAreIgnored [

	importer importString: '<other a="1" /><bd serie="Gaston" />'.
	self assert: library owned size equals: 1
]
