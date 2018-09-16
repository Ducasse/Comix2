"
To automate some mess that we will throw once the migration will be done for real.


CXPersonalSetup new setUp
"
Class {
	#name : #CXPersonalSetup,
	#superclass : #CXTools,
	#category : #'Comix-Tools'
}

{ #category : #initialization }
CXPersonalSetup >> setUp [ 

	| file |
	"copy latest XMl file."
	file := (('/Users/ducasse/Workspace/FirstCircle/Working/SW2' asFileReference) lastFileFor: 'BD' extension: 'xml').
	file copyTo: FileSystem workingDirectory / file basename.
]
