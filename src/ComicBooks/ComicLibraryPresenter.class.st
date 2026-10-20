Class {
	#name : 'ComicLibraryPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'library',
		'tree',
		'addButton',
		'addSeriesButton'
	],
	#category : 'ComicBooks-UI',
	#package : 'ComicBooks',
	#tag : 'UI'
}

{ #category : 'private' }
ComicLibraryPresenter >> addBookToSeries: aSeries [
	| dialog |
	dialog := ComicBookDialogPresenter new.
	(dialog asModalWindow)
		okAction: [
			| book |
			book := ComicBook
				title: dialog title
				author: dialog author
				volumeNumber: dialog volumeNumber.
			aSeries addChild: book.
			tree roots: library nodes ];
		open
]

{ #category : 'accessing' }
ComicLibraryPresenter >> addButton [
	^ addButton
]

{ #category : 'private' }
ComicLibraryPresenter >> addLooseBook [
	| dialog |
	dialog := ComicBookDialogPresenter new
		showVolumeNumber: false;
		yourself.
	(dialog asModalWindow)
		okAction: [
			| book |
			book := ComicBook
				title: dialog title
				author: dialog author
				volumeNumber: nil.
			library addLooseBook: book.
			tree roots: library nodes ];
		open
]

{ #category : 'private' }
ComicLibraryPresenter >> addNode [
	| selected |
	selected := self selectedNode.
	selected isNil ifTrue: [ ^ self addLooseBook ].
	(selected isKindOf: ComicSeries)
		ifTrue: [ ^ self addBookToSeries: selected ].
	"A book is selected — find its parent series if any"
	library series
		detect: [ :s | s children includes: selected ]
		ifFound: [ :s | self addBookToSeries: s ]
		ifNone: [ self addLooseBook ]
]

{ #category : 'private' }
ComicLibraryPresenter >> addSeries [
	| dialog |
	dialog := self application newRequest
		title: 'Add series';
		label: 'Series name:';
		yourself.
	dialog openModal
		ifNotNil: [ :name |
			name isEmpty ifFalse: [
				library addSeries: (ComicSeries name: name).
				tree roots: library nodes ] ]
]

{ #category : 'accessing' }
ComicLibraryPresenter >> addSeriesButton [
	^ addSeriesButton
]

{ #category : 'initialization' }
ComicLibraryPresenter >> connectPresenters [
	addButton action: [ self addNode ].
	addSeriesButton action: [ self addSeries ]
]

{ #category : 'initialization' }
ComicLibraryPresenter >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight
			add: addButton;
			add: addSeriesButton;
			yourself) expand: false;
		add: tree;
		yourself
]

{ #category : 'initialization' }
ComicLibraryPresenter >> initializePresenters [
	tree := self newTree
		children: [ :node | node children ];
		display: [ :node | node displayName ];
		yourself.
	addButton := self newButton
		label: 'Add book';
		yourself.
	addSeriesButton := self newButton
		label: 'Add series';
		yourself
]

{ #category : 'initialization' }
ComicLibraryPresenter >> initializeWindow: aWindow [
	aWindow
		title: 'My comic books';
		initialExtent: 400 @ 500
]

{ #category : 'accessing' }
ComicLibraryPresenter >> library [
	^ library
]

{ #category : 'accessing' }
ComicLibraryPresenter >> library: aComicLibrary [
	library := aComicLibrary.
	tree roots: library nodes
]

{ #category : 'accessing' }
ComicLibraryPresenter >> selectedNode [
	^ tree selectedItem
]

{ #category : 'accessing' }
ComicLibraryPresenter >> tree [
	^ tree
]
