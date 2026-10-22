Class {
	#name : 'CBWantedAlbumTest',
	#superclass : 'TestCase',
	#category : 'CBComix-Tests-Core',
	#package : 'CBComix-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
CBWantedAlbumTest >> testDefaults [

	| wanted |
	wanted := CBWantedAlbum new.
	self assert: wanted seriesName isEmpty.
	self deny: wanted hasNumber.
	self assert: wanted title isEmpty.
	self assert: wanted notes isEmpty
]

{ #category : 'tests' }
CBWantedAlbumTest >> testIsInSeriesNamedIgnoresCaseAndSpaces [

	| wanted |
	wanted := CBWantedAlbum seriesName: 'Gaston' number: 10.
	self assert: (wanted isInSeriesNamed: ' gaston ').
	self deny: (wanted isInSeriesNamed: 'Spirou')
]

{ #category : 'tests' }
CBWantedAlbumTest >> testPrintOn [

	self assert: (CBWantedAlbum seriesName: 'Gaston' number: 10) printString equals: 'wanted: Gaston 10'
]

{ #category : 'tests' }
CBWantedAlbumTest >> testSeriesNameNumber [

	| wanted |
	wanted := CBWantedAlbum seriesName: 'Gaston' number: 10.
	self assert: wanted seriesName equals: 'Gaston'.
	self assert: wanted number equals: 10.
	self assert: wanted hasNumber
]
