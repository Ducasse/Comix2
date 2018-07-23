Class {
	#name : #CXSeriePrinter,
	#superclass : #CXAbstractLaTeXPrinter,
	#category : #'Comix-Tools'
}

{ #category : #latex }
CXSeriePrinter >> columns [

	^ 'twocolumn'
]

{ #category : #initialization }
CXSeriePrinter >> defaultFileName [

	^ 'Series'
]

{ #category : #operate }
CXSeriePrinter >> visitSerie: aSerie [

	
]
