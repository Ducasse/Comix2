Class {
	#name : #CXCompleteChecker,
	#superclass : #CXSanitizer,
	#category : #'Comix-Tools'
}

{ #category : #operations }
CXCompleteChecker >> visitSerie: aSerie [
	"if the serie is marked as complete and not all the elements are not there is a problem"
	| markedAllBds |
	markedAllBds := aSerie bds allSatisfy: [ :each | each serieComplete ].
	aSerie isSerieComplete and: [ markedAllBds not ifTrue: [ self log: aSerie ]]. 
	 
]
