"
To automate some mess that we will throw once the migration will be done for real.
"
Class {
	#name : #CXPersonalSetup,
	#superclass : #CXTools,
	#category : #'Comix-Tools'
}

{ #category : #initialization }
CXPersonalSetup >> setUp [ 

	"copy latest XMl file."
	('/Users/ducasse/Workspace/FirstCircle/Working/SW2' asFileReference) lastFileFor: 'BD' extension: 'xml' 
]
