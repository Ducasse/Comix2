Class {
	#name : 'ComicBookDialogPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'titleInput',
		'authorInput',
		'volumeNumberInput',
		'showVolumeNumber'
	],
	#category : 'ComicBooks-UI',
	#package : 'ComicBooks',
	#tag : 'UI'
}

{ #category : 'accessing' }
ComicBookDialogPresenter >> author [

	^ authorInput text trimBoth
]

{ #category : 'accessing' }
ComicBookDialogPresenter >> authorInput [
	^ authorInput
]

{ #category : 'initialization' }
ComicBookDialogPresenter >> defaultLayout [
	| box |
	box := SpBoxLayout newTopToBottom
		spacing: 5;
		add: (self newLabel label: 'Title:') expand: false;
		add: titleInput expand: false;
		add: (self newLabel label: 'Author:') expand: false;
		add: authorInput expand: false.
	showVolumeNumber ifTrue: [
		box
			add: (self newLabel label: 'Volume number:') expand: false;
			add: volumeNumberInput expand: false ].
	^ box
]

{ #category : 'initialization' }
ComicBookDialogPresenter >> initialize [
	super initialize.
	showVolumeNumber := true
]

{ #category : 'initialization' }
ComicBookDialogPresenter >> initializePresenters [
	titleInput := self newTextInput placeholder: 'Title'.
	authorInput := self newTextInput placeholder: 'Author'.
	volumeNumberInput := self newTextInput placeholder: 'Volume number (optional)'
]

{ #category : 'initialization' }
ComicBookDialogPresenter >> initializeWindow: aWindow [
	aWindow
		title: 'Add book';
		initialExtent: 300 @ (showVolumeNumber ifTrue: [ 250 ] ifFalse: [ 180 ])
]

{ #category : 'accessing' }
ComicBookDialogPresenter >> showVolumeNumber: aBoolean [
	showVolumeNumber := aBoolean
]

{ #category : 'accessing' }
ComicBookDialogPresenter >> title [

	^ titleInput text trimBoth
]

{ #category : 'accessing' }
ComicBookDialogPresenter >> titleInput [
	^ titleInput
]

{ #category : 'accessing' }
ComicBookDialogPresenter >> volumeNumber [
	| text |
	text := volumeNumberInput text trimmed.
	^ text isEmpty
		ifTrue: [ nil ]
		ifFalse: [ text asInteger ]
]

{ #category : 'accessing' }
ComicBookDialogPresenter >> volumeNumberInput [
	^ volumeNumberInput
]
