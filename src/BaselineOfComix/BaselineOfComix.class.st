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
		do: [ spec
				project: 'XMLParser'
				with: [ spec
						className: #ConfigurationOfXMLParser;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'.
				spec package: 'Comix' 
				]
			]
]
