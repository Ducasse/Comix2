"
For now manage original and not original. 
Once we have series connected and saved. 
We will be able to document better: complete or not.

```
CXSeriePrinter new
	setBase: (CXBase stefBase addNewSerieFromCollection: CXXMLImporter stefBds);	
	setWorkingDirectoryFromBase;
	save.
```
"
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
	^ 'TwoColumnsSeries'
]

{ #category : #operate }
CXSeriePrinter >> doBase [
	base seriesDo: [ :aSerie | 
		(aSerie bds size = 1 and: [ aSerie bds first original not ])
				ifFalse: [ self visitSerie: aSerie ]]
]

{ #category : #visiting }
CXSeriePrinter >> doSerie: aSerie [
	aSerie bdsDo: [ :each | self visitItem: each ]
]

{ #category : #operate }
CXSeriePrinter >> postSerie: aSerie [
	stream
		nextPutAll: '\squishend';
		cr
]

{ #category : #operate }
CXSeriePrinter >> preSerie: aSerie [
	stream
		nextPutAll: '\squishlist';
		cr
]

{ #category : #operate }
CXSeriePrinter >> visitItem: anItem [
	stream
		<< '\item[';
		<< anItem publicNumber printString;
		<< ']';
		space;
		<< ' - ';
		<< anItem title asString;
		space;
		<< ' - ';
		<<
			(anItem year
				ifNotNil: [ :y | 
					y printString size = 4
						ifTrue: [ y printString copyFrom: 3 to: 4 ]
						ifFalse: [ y printString ] ]
				ifNil: [ '' ]);
		space;
		<<
			(anItem original
				ifFalse: [ 'NOr' ]
				ifTrue: [ '' ]);
		cr
]

{ #category : #operate }
CXSeriePrinter >> visitSerie: aSerie [
	stream
		space;
		cr.
	stream
		<< '\paragraph{';
		<< aSerie title asString;
		<< '}';
		cr;
		cr;
		<< '\noindent ';
		<< 'Ms:';
		<< aSerie missingNumberString;
		cr.
	super visitSerie: aSerie
]
