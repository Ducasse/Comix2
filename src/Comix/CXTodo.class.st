Class {
	#name : #CXTodo,
	#superclass : #Object,
	#category : #'Comix-Model'
}

{ #category : #'accessing structure variables' }
CXTodo >> a [

	" add test for sortedAs 
	for bd number should use numberOnCover and not sortedAs
	we should revisit it for strange collection"
]

{ #category : #'accessing structure variables' }
CXTodo >> b [

	" should model range based series such as manga
	to say that we have 1 to 11, 13, 15 to 18"
]

{ #category : #'accessing structure variables' }
CXTodo >> b1 [

	" title may be rawTitle + number
	
	Serie: Vortex 
	Raw: Tess Wood
	NumberOnCover: 2
	?
	ou Number
	
	Vortex
		1 Tess wood 1
		2 Tess wood 2
		1 Campbell 1
		2 Campbell 2
		3 Tess and Campbell 3
	
	
	
	
	Les immonables
	
		Serie: Immonables (Premiere Edition)
		rawTitle: Aventure en Jaune
		Number 
		Variation: 'A' ou '1'  pour les differentes couvertures
		
		64a . Alix-Noni-Tengu (fin heureuse)
		64b . Alix-Noni-Tengu (fin triste)
		
=> missing ne peut pas marcher pour ces albums 
=> il faut gerer une collection recherche pour les albums manquants.


		
	"

]

{ #category : #'accessing structure variables' }
CXTodo >> c [

	" should model series explicitly from an item ie not as strings."
]

{ #category : #'accessing structure variables' }
CXTodo >> c2 [

	" mini serie should filter completed series"
]

{ #category : #'accessing structure variables' }
CXTodo >> d [

	"not sure unitSerie makes sense"
]
