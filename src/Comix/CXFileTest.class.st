Class {
	#name : #CXFileTest,
	#superclass : #TestCase,
	#instVars : [
		'testingWorkingDirectory'
	],
	#category : #'Comix-Tests'
}

{ #category : #data }
CXFileTest class >> contentsForTest [

	^ ''
]

{ #category : #resources }
CXFileTest class >> fileNameForTest [
	^ 'BD.ston'
]

{ #category : #initialization }
CXFileTest >> initialize [
	super initialize.
	testingWorkingDirectory := FileSystem memory workingDirectory
]

{ #category : #setup }
CXFileTest >> setUp [

	super setUp.
	(testingWorkingDirectory / self class fileNameForTest)
		writeStreamDo: [ :stream | 
			stream nextPutAll: self class contentsForTest ].
		

]
