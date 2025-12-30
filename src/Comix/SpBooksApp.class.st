Class {
	#name : 'SpBooksApp',
	#superclass : 'SpApplication',
	#category : 'Comix-UI',
	#package : 'Comix',
	#tag : 'UI'
}

{ #category : 'running' }
SpBooksApp class >> run [
	<script>
	| app pre |
	app := self new.
	"to be removed later"
	CXCollector uniqueInstance add: 
		(CXBase new 
			kind: 'BD';
			addNewSeriesFromCollection: CXXMLImporter importStefBdsAsPlainList; yourself).
	pre := SpSerieListPresenter newApplication: app model: (CXCollector uniqueInstance baseFor: 'BD').
	pre open
]
