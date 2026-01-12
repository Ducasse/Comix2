Class {
	#name : 'CXSerie',
	#superclass : 'CXSeriable',
	#category : 'Comix-Model',
	#package : 'Comix',
	#tag : 'Model'
}

{ #category : 'sample' }
CXSerie class >> potro [

	^ STON fromString: 'CXSerie {
	#title : ''Donjon potron-minet'',
	#sortedAs : ''Donjon potron-minet'',
	#serieComplete : false,
	#bds : OrderedCollection [
		CXItem {
			#title : ''Une jeunesse qui s\''enfuit'',
			#entryCreationDate : Date [ ''2006-05-05+01:00'' ],
			#entryNumber : 208,
			#year : 2003,
			#serie : @1,
			#original : true,
			#authors : ''Blain Sfar Trondheim'',
			#number : 3,
			#numberOnCover : 97,
			#serieComplete : false
		},
		CXItem {
			#title : ''Un justicier dans l\''ennui'',
			#entryCreationDate : Date [ ''2006-05-05+01:00'' ],
			#entryNumber : 209,
			#year : 2001,
			#serie : @1,
			#original : true,
			#authors : ''Blain Sfar Trondheim'',
			#number : 2,
			#numberOnCover : 98,
			#serieComplete : false
		},
		CXItem {
			#title : ''La chemise de la nuit'',
			#entryCreationDate : Date [ ''2006-05-05+01:00'' ],
			#entryNumber : 210,
			#year : 1999,
			#serie : @1,
			#original : true,
			#authors : ''Blain '',
			#number : 1,
			#numberOnCover : 99,
			#serieComplete : false
		},
		CXItem {
			#title : ''Apres la pluie'',
			#entryCreationDate : Date [ ''2006-10-10+01:00'' ],
			#entryNumber : 1667,
			#year : 2006,
			#serie : @1,
			#original : true,
			#authors : ''Blain Sfar Trondheim'',
			#number : 4,
			#numberOnCover : -84,
			#serieComplete : false
		},
		CXItem {
			#title : ''Sans un bruit'',
			#entryCreationDate : Date [ ''2008-11-01+01:00'' ],
			#entryNumber : 2168,
			#year : 2008,
			#serie : @1,
			#original : true,
			#authors : ''Gaultier Sfar Trondheim'',
			#number : 5,
			#numberOnCover : -83,
			#serieComplete : false
		}
	]
}'
]

{ #category : 'missing' }
CXSerie >> missingNumberString [

	^ String streamContents: [ :str | 
			self missingNumbers first 
				do: [:missing | str nextPutAll: missing asString] 
				separatedBy: [str nextPut: Character space]]
]

{ #category : 'printing' }
CXSerie >> printOn: aStream [

	aStream << 'Serie '.
	aStream space.
	aStream << title
]
