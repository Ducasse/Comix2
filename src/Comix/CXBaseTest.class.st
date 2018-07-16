Class {
	#name : #CXBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'testingWorkingDirectory'
	],
	#category : #'Comix-Model'
}

{ #category : #resources }
CXBaseTest class >> contentsForTest [ 

	^ 'OrderedCollection [
		CXItem {
			#title : ''Total souk pour nic oumouk'',
			#entryCreationDate : ''25 March 2006'',
			#entryNumber : ''1'',
			#editor : ''Dargaud'',
			#year : ''2005'',
			#serie : ''Nic oumouk'',
			#original : ''true'',
			#authors : ''Larcenet'',
			#number : ''1'',
			#serieComplete : ''false''
		},
		CXItem {
			#title : ''Nao'',
			#notes : ''marqué second edition mais c\''est normal!. apparemment il y a une version avec couv rouge de 1988 ensuite la version 2002 a un cahier de 8 pages.'',
			#entryCreationDate : ''5 May 2006'',
			#entryNumber : ''28'',
			#editor : ''Delcourt'',
			#year : ''1989'',
			#serie : ''Aquablue'',
			#original : ''false'',
			#authors : ''Cailleteau  Vatine'',
			#number : ''1'',
			#serieComplete : ''false'',
			#coverPictureName : ''Aquablue01a-1989.jpg''
		},
		CXItem {
			#title : ''Planete Bleue'',
			#entryCreationDate : ''5 May 2006'',
			#entryNumber : ''29'',
			#year : ''1989'',
			#serie : ''Aquablue'',
			#original : ''true'',
			#authors : ''Cailleteau  Vatine'',
			#number : ''2'',
			#serieComplete : ''false'',
			#coverPictureName : ''Aquablue02a-1989.jpg''
		},
		CXItem {
			#title : ''Le megophias'',
			#entryCreationDate : ''5 May 2006'',
			#entryNumber : ''30'',
			#editor : ''Delcourt'',
			#year : ''1990'',
			#serie : ''Aquablue'',
			#original : ''true'',
			#authors : ''Cailleteau  Vatine'',
			#number : ''3'',
			#serieComplete : ''false'',
			#coverPictureName : ''Aquablue03-1990.jpg''
		},
		CXItem {
			#title : ''Etoile Blanche (premiere partie)'',
			#entryCreationDate : ''5 May 2006'',
			#entryNumber : ''31'',
			#editor : ''Delcourt'',
			#year : ''1994'',
			#serie : ''Aquablue'',
			#original : ''true'',
			#authors : ''Cailleteau  Vatine'',
			#number : ''6'',
			#serieComplete : ''false'',
			#coverPictureName : ''Aquablue06-1994.jpg''
		},
		CXItem {
			#title : ''Foundation aquablue'',
			#entryCreationDate : ''5 May 2006'',
			#entryNumber : ''32'',
			#editor : ''Delcourt'',
			#year : ''2001'',
			#serie : ''Aquablue'',
			#original : ''true'',
			#authors : ''Cailleteau Tota'',
			#number : ''8'',
			#serieComplete : ''false'',
			#coverPictureName : ''Aquablue08-2001.jpg''
		},
		CXItem {
			#title : ''Aya de Yopougon'',
			#entryCreationDate : ''2 July 2018'',
			#entryNumber : ''2876'',
			#editor : ''Gallimard'',
			#year : ''2006'',
			#serie : ''Aya de Yopougon'',
			#original : ''true'',
			#authors : ''Abouet Oubrerie'',
			#number : ''2'',
			#serieComplete : ''false''
		}]
}'
]

{ #category : #resources }
CXBaseTest class >> contentsForTestOld [

	^ 'CXBase {
	#bds : OrderedCollection [
		CXItem {
			#title : ''Total souk pour nic oumouk'',
			#entryCreationDate : ''25 March 2006'',
			#entryNumber : ''1'',
			#editor : ''Dargaud'',
			#year : ''2005'',
			#serie : ''Nic oumouk'',
			#original : ''true'',
			#authors : ''Larcenet'',
			#number : ''1'',
			#serieComplete : ''false''
		},
		CXItem {
			#title : ''Nao'',
			#notes : ''marqué second edition mais c\''est normal!. apparemment il y a une version avec couv rouge de 1988 ensuite la version 2002 a un cahier de 8 pages.'',
			#entryCreationDate : ''5 May 2006'',
			#entryNumber : ''28'',
			#editor : ''Delcourt'',
			#year : ''1989'',
			#serie : ''Aquablue'',
			#original : ''false'',
			#authors : ''Cailleteau  Vatine'',
			#number : ''1'',
			#serieComplete : ''false'',
			#coverPictureName : ''Aquablue01a-1989.jpg''
		},
		CXItem {
			#title : ''Planete Bleue'',
			#entryCreationDate : ''5 May 2006'',
			#entryNumber : ''29'',
			#year : ''1989'',
			#serie : ''Aquablue'',
			#original : ''true'',
			#authors : ''Cailleteau  Vatine'',
			#number : ''2'',
			#serieComplete : ''false'',
			#coverPictureName : ''Aquablue02a-1989.jpg''
		},
		CXItem {
			#title : ''Le megophias'',
			#entryCreationDate : ''5 May 2006'',
			#entryNumber : ''30'',
			#editor : ''Delcourt'',
			#year : ''1990'',
			#serie : ''Aquablue'',
			#original : ''true'',
			#authors : ''Cailleteau  Vatine'',
			#number : ''3'',
			#serieComplete : ''false'',
			#coverPictureName : ''Aquablue03-1990.jpg''
		},
		CXItem {
			#title : ''Etoile Blanche (premiere partie)'',
			#entryCreationDate : ''5 May 2006'',
			#entryNumber : ''31'',
			#editor : ''Delcourt'',
			#year : ''1994'',
			#serie : ''Aquablue'',
			#original : ''true'',
			#authors : ''Cailleteau  Vatine'',
			#number : ''6'',
			#serieComplete : ''false'',
			#coverPictureName : ''Aquablue06-1994.jpg''
		},
		CXItem {
			#title : ''Foundation aquablue'',
			#entryCreationDate : ''5 May 2006'',
			#entryNumber : ''32'',
			#editor : ''Delcourt'',
			#year : ''2001'',
			#serie : ''Aquablue'',
			#original : ''true'',
			#authors : ''Cailleteau Tota'',
			#number : ''8'',
			#serieComplete : ''false'',
			#coverPictureName : ''Aquablue08-2001.jpg''
		},
		CXItem {
			#title : ''Aya de Yopougon'',
			#entryCreationDate : ''2 July 2018'',
			#entryNumber : ''2876'',
			#editor : ''Gallimard'',
			#year : ''2006'',
			#serie : ''Aya de Yopougon'',
			#original : ''true'',
			#authors : ''Abouet Oubrerie'',
			#number : ''2'',
			#serieComplete : ''false''
		}]
}'
]

{ #category : #resources }
CXBaseTest class >> fileNameForTest [

	^ 'BD.ston'
]

{ #category : #setup }
CXBaseTest >> base [
	"self new base"
	STON fromStream: self stonFile contents
]

{ #category : #setup }
CXBaseTest >> setUp [

	super setUp.
	testingWorkingDirectory := FileSystem memory workingDirectory.
	(testingWorkingDirectory / self class fileNameForTest)
		writeStreamDo: [ :stream | 
			stream nextPutAll: self class contentsForTest ].
		

]

{ #category : #setup }
CXBaseTest >> stonFile [

	^ (testingWorkingDirectory / self class fileNameForTest)
]

{ #category : #setup }
CXBaseTest >> testAddNewSerieFromCollection [
	"self new testAddNewSerieFromCollection"
	
	| base col |
	base := CXBase new.  
	col := (STON fromString: self stonFile contents).
	base addNewSerieFromCollection: col.
	self assert: base series size equals: 3. 
]

{ #category : #setup }
CXBaseTest >> testCollection [
	"self new testCollection"
	
	| bds | 
	bds := (STON fromString: self stonFile contents).
	self assert: bds size equals: 7
]

{ #category : #setup }
CXBaseTest >> testSerieNamed [
	"self new testSerieNamed"
	
	| base col oumok aquablue |
	base := CXBase new.  
	col := (STON fromString: self stonFile contents).
	base addNewSerieFromCollection: col.
	oumok := (base serieNamed: 'Nic oumouk').
	self assert: oumok bds size equals: 1. 
	aquablue := (base serieNamed: 'Aquablue').
	self assert: aquablue bds size equals: 5. 
]
