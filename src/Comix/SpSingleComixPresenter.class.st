Class {
	#name : 'SpSingleComixPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'bdTitle',
		'serieTitle',
		'number',
		'year',
		'editor',
		'authors',
		'original'
	],
	#category : 'Comix-UI',
	#package : 'Comix',
	#tag : 'UI'
}

{ #category : 'examples' }
SpSingleComixPresenter class >> sample [
	<script>
	"self sample"
	
	^ (self on:  CXSerie potro bds first) open
]

{ #category : 'layout' }
SpSingleComixPresenter >> defaultLayout [

	^ SpGridLayout new
		  beColumnNotHomogeneous;
		  column: 2 expand: true;
		  build: [ :builder |
				  builder
					  add: 'Serie'; add: serieTitle; nextRow;
					  add: 'Number'; add: number; nextRow;
					  add: 'Titre'; add: bdTitle; nextRow;
					  add: 'Year'; add: year; nextRow; 
					  add: 'Publisher'; add: editor; nextRow;
					  add: 'Authors'; add: authors; nextRow;
					add: 'Original'; add: original; nextRow
					];
		  yourself
]

{ #category : 'layout' }
SpSingleComixPresenter >> initializePresenter [

	bdTitle := self newTextInput.
	bdTitle text: self model title.
	serieTitle := self newTextInput.
	serieTitle text: self model serie title.
	number := self newTextInput.
	number text: self model number asString.
	year := self newTextInput.
	year text: self model year asString.
	authors := self newTextInput.
	authors text: self model authors.
	original := self newCheckBox.
	original state: self model original.
	original disable.
]
