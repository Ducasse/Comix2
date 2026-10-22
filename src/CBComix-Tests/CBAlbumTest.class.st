Class {
	#name : 'CBAlbumTest',
	#superclass : 'TestCase',
	#instVars : [
		'album',
		'series'
	],
	#category : 'CBComix-Tests-Core',
	#package : 'CBComix-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
CBAlbumTest >> setUp [

	super setUp.
	series := CBSeries named: 'Gaston'.
	series addTag: #belgian.
	album := CBAlbum new
		         title: 'Lagaffe mérite des baffes';
		         number: 13;
		         series: series;
		         yourself
]

{ #category : 'tests' }
CBAlbumTest >> testAuthors [

	| franquin |
	franquin := CBAuthor named: 'Franquin'.
	album addAuthor: franquin.
	album addAuthor: franquin.
	self assert: album authors asArray equals: { franquin }.
	album removeAuthor: franquin.
	self assert: album authors isEmpty
]

{ #category : 'tests' }
CBAlbumTest >> testDefaults [

	| fresh |
	fresh := CBAlbum new.
	self assert: fresh title isEmpty.
	self deny: fresh hasNumber.
	self deny: fresh hasYear.
	self assert: fresh isOriginal.
	self assert: fresh notes isEmpty.
	self assert: fresh authors isEmpty.
	self assert: fresh entryDate equals: Date today
]

{ #category : 'tests' }
CBAlbumTest >> testDisplayPrintOn [

	self 
		assert: album displayString 
		equals: 'Gaston 13 - Lagaffe mérite des baffes'
]

{ #category : 'tests' }
CBAlbumTest >> testHasNumberAndYear [

	album year: 1979.
	self assert: album hasNumber.
	self assert: album hasYear
]

{ #category : 'tests' }
CBAlbumTest >> testPrintOn [

	self 
		assert: album printString 
		equals: 'a CBAlbum (Gaston 13 - Lagaffe mérite des baffes)'
]

{ #category : 'tests' }
CBAlbumTest >> testTagsComeFromSeries [

	self assert: (album hasTag: #belgian).
	self deny: (album hasTag: #usa).
	series addTag: #humor.
	self assert: (album hasTag: #humor).
	self assert: album tags equals: series tags
]
