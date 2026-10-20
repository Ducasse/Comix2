Class {
	#name : 'ComicBookListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'books',
		'bookList',
		'addButton'
	],
	#category : 'ComicBooks-UI',
	#package : 'ComicBooks',
	#tag : 'UI'
}

{ #category : 'private' }
ComicBookListPresenter >> addBook [
	| dialog book |
	dialog := ComicBookDialogPresenter new.
	dialog openDialog
		okAction: [
			book := ComicBook title: dialog title author: dialog author.
			books add: book.
			bookList items: books copy ]
]

{ #category : 'accessing' }
ComicBookListPresenter >> books [
	^ books
]

{ #category : 'accessing' }
ComicBookListPresenter >> books: aCollection [
	books := aCollection.
	bookList items: books
]

{ #category : 'initialization' }
ComicBookListPresenter >> connectPresenters [
	addButton action: [ self addBook ]
]

{ #category : 'initialization' }
ComicBookListPresenter >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: addButton expand: false;
		add: bookList;
		yourself
]

{ #category : 'initialization' }
ComicBookListPresenter >> initializeLayout [
	self layout: (SpBoxLayout newTopToBottom
		add: bookList;
		yourself)
]

{ #category : 'initialization' }
ComicBookListPresenter >> initializePresenters [
	bookList := self newTable
		addColumn: (SpStringTableColumn title: 'Title' evaluated: #title);
		addColumn: (SpStringTableColumn title: 'Author' evaluated: #author);
		yourself.
	addButton := self newButton
		label: 'Add book';
		yourself
]

{ #category : 'initialization' }
ComicBookListPresenter >> initializeWindow: aWindow [
	aWindow title: 'My comic books'
]
