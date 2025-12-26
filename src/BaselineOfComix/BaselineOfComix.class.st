Class {
	#name : 'BaselineOfComix',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfComix',
	#package : 'BaselineOfComix'
}

{ #category : 'baselines' }
BaselineOfComix >> baseline: spec [
	<baseline>
	
	spec
		for: #common
		do: [ 
			spec
			baseline: 'XMLParser' 
			with: [ spec repository: 'github://pharo-contributions/XML-XMLParser/src' ].
	spec package: 'Comix' with: [ spec requires: #('XMLParser') ] ]
			
		
	
	
]
