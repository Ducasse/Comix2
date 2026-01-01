Class {
	#name : 'SpComixPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'menuBar'
	],
	#category : 'Comix-UI',
	#package : 'Comix',
	#tag : 'UI'
}

{ #category : 'layout' }
SpComixPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
			add: menuBar ; 
			yourself
]

{ #category : 'initialization' }
SpComixPresenter >> initializeMenuBar [

	menuBar := self newMenuBar 
		addItem: [ :item | item name: 'Series'; 
			subMenu: self serieMenu;
			yourself ]
]

{ #category : 'initialization' }
SpComixPresenter >> initializePresenters [ 

	self initializeMenuBar
]

{ #category : 'initialization' }
SpComixPresenter >> initializeWindow: aWindowPresenter [
aWindowPresenter
title: 'Mail';
initialExtent: 650@500;
menu: menuBar
]

{ #category : 'initialization' }
SpComixPresenter >> openSeries [

	 (SpSerieListPresenter 
		newApplication: application 
		model: (CXCollector uniqueInstance baseFor: 'BD'))
		open
]

{ #category : 'initialization' }
SpComixPresenter >> serieMenu [

	^ self newMenu 
		addGroup: [ :group |
			  group addItem: [ :item |
					  item
						  name: 'Open';
						  shortcut: $n meta;
						  action: [ self openSeries ] ] ]
]
