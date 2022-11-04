Class {
	#name : #BaselineOfComix,
	#superclass : #BaselineOf,
	#category : #BaselineOfComix
}

{ #category : #baselines }
BaselineOfComix >> baseline: spec [
	<baseline>
	
	spec
		for: #common
		do: [ 
			spec
				baseline: 'XMLParser'
				with: [ 
					spec
						loads: #('Core');
						repository: 'github://pharo-contributions/XML-XMLParser/src'
			
			"spec
					project: 'XMLParser'
					with: [ spec
								className: #ConfigurationOfXMLParser;
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' "].
				spec package: 'Comix' with: [ spec requires: #('XMLParser') ] ]
			
]
