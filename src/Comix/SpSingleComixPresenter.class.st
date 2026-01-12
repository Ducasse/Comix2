Class {
	#name : 'SpSingleComixPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'bdTitle',
		'serieTitle',
		'number'
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

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: bdTitle;
				   yourself);
		 add: (SpBoxLayout newLeftToRight
				   add: serieTitle;
				   yourself);
		add: (SpBoxLayout newLeftToRight
				   add: number;
				   yourself);
		  yourself
]

{ #category : 'layout' }
SpSingleComixPresenter >> initializePresenter [

	bdTitle := self newTextInput.
	bdTitle text: self model title.
	serieTitle := self newTextInput.
	serieTitle text: self model serie title.
	number := self newTextInput.
	number text: self model number asString
]
