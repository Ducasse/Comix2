Class {
	#name : #BDBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'testingWorkingDirectory'
	],
	#category : #Comix
}

{ #category : #'as yet unclassified' }
BDBaseTest class >> contentsForTest [ 

	^ ''
]

{ #category : #'as yet unclassified' }
BDBaseTest class >> fileNameForTest [

	^ 'BD.ston'
]

{ #category : #setup }
BDBaseTest >> setUp [

	super setUp.
	testingWorkingDirectory := FileSystem memory workingDirectory.
	(testingWorkingDirectory / self class fileNameForTest)
		writeStreamDo: [ :stream | 
			stream nextPutAll: self class contentsForTest ]
]
