Class {
	#name : 'SpSerieListPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'list',
		'seriesList',
		'elementList'
	],
	#category : 'Comix-UI',
	#package : 'Comix',
	#tag : 'UI'
}

{ #category : 'layout' }
SpSerieListPresenter >> connectPresenters [ 


	seriesList  whenSelectedDo: [ :aSerie | 
		elementList items: aSerie bds ]
]

{ #category : 'layout' }
SpSerieListPresenter >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
			add: (SpBoxLayout newLeftToRight
					add: seriesList;
					add: elementList;
					yourself);
					yourself
			
		
]

{ #category : 'layout' }
SpSerieListPresenter >> initializePresenters [

	seriesList := self newList.
	seriesList display: [ :each | each title , (each isSerieComplete ifTrue: [ ' x ' ] ifFalse: [ ' - ' ])].
	elementList := self newList.
	
			
]

{ #category : 'initialization' }
SpSerieListPresenter >> initializeWindow: aWindowPresenter [
aWindowPresenter
title: 'Comix';
initialExtent: 400@294
]

{ #category : 'layout' }
SpSerieListPresenter >> modelChanged [

	seriesList items: self model series 
]
