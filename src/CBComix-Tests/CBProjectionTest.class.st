Class {
	#name : 'CBProjectionTest',
	#superclass : 'TestCase',
	#instVars : [
		'library',
		'gaston9',
		'blake1',
		'watchmen'
	],
	#category : 'CBComix-Tests',
	#package : 'CBComix-Tests'
}

{ #category : 'running' }
CBProjectionTest >> setUp [

	super setUp.
	library := CBLibrary new.
	(library seriesNamed: 'Gaston') addTag: #belgian.
	(library seriesNamed: 'Blake et Mortimer') addTag: #belgian.
	(library seriesNamed: 'Watchmen') addTag: #usa.
	gaston9 := library addAlbum: (CBAlbum new
			            series: (library seriesNamed: 'Gaston');
			            number: 9;
			            year: 1971;
			            yourself).
	blake1 := library addAlbum: (CBAlbum new
			           series: (library seriesNamed: 'Blake et Mortimer');
			           number: 1;
			           year: 1950;
			           yourself).
	watchmen := library addAlbum: (CBAlbum new
			             series: (library seriesNamed: 'Watchmen');
			             number: 1;
			             year: 1987;
			             yourself)
]

{ #category : 'tests' }
CBProjectionTest >> testAlbumsAreSharedWithSource [

	| belgian |
	belgian := library owned projectionNamed: 'belgian' rule: [ :each | each hasTag: #belgian ].
	self assert: belgian size equals: 2.
	self assert: (belgian albums includes: gaston9).
	self assert: (belgian albums detect: [ :each | each == gaston9 ]) identicalTo: gaston9
]

{ #category : 'tests' }
CBProjectionTest >> testChainedProjection [

	| belgian old |
	belgian := library owned projectionNamed: 'belgian' rule: [ :each | each hasTag: #belgian ].
	old := belgian projectionNamed: 'old belgian' rule: [ :each | each year < 1960 ].
	self assert: old source identicalTo: belgian.
	self assert: old albums asArray equals: { blake1 }
]

{ #category : 'tests' }
CBProjectionTest >> testDefaultRuleKeepsEverything [

	| all |
	all := CBProjection new
		       source: library owned;
		       yourself.
	self assert: all size equals: 3.
	self assert: CBProjection new isEmpty
]

{ #category : 'tests' }
CBProjectionTest >> testFollowsSourceChanges [

	| belgian spirou |
	belgian := library owned projectionNamed: 'belgian' rule: [ :each | each hasTag: #belgian ].
	(library seriesNamed: 'Spirou') addTag: #belgian.
	spirou := library addAlbum: (CBAlbum new
			           series: (library seriesNamed: 'Spirou');
			           yourself).
	self assert: (belgian includes: spirou).
	library removeAlbum: gaston9.
	self deny: (belgian includes: gaston9).
	self assert: belgian size equals: 2
]

{ #category : 'tests' }
CBProjectionTest >> testSameProtocolAsCollection [

	| usa |
	usa := library owned projectionNamed: 'usa' rule: [ :each | each hasTag: #usa ].
	self assert: usa name equals: 'usa'.
	self assert: (usa albumsOfSeries: (library seriesNamed: 'Watchmen')) asArray equals: { watchmen }.
	self assert: (usa select: [ :each | each year = 1987 ]) asArray equals: { watchmen }.
	self assert: usa printString equals: 'usa (1 albums)'
]
