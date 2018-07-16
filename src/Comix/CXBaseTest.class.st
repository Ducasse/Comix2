Class {
	#name : #CXBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'testingWorkingDirectory'
	],
	#category : #'Comix-Tools'
}

{ #category : #'as yet unclassified' }
CXBaseTest class >> contentsForTest [ 

	^ ''
]

{ #category : #'as yet unclassified' }
CXBaseTest class >> fileNameForTest [

	^ 'BD.ston'
]

{ #category : #setup }
CXBaseTest >> setUp [

	super setUp.
	testingWorkingDirectory := FileSystem memory workingDirectory.
	(testingWorkingDirectory / self class fileNameForTest)
		writeStreamDo: [ :stream | 
			stream nextPutAll: self class contentsForTest ]
]
