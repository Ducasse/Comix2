Extension { #name : 'Stream' }

{ #category : '*CBComix' }
Stream >> displayPrint: anObject [
	"Have anObject print itself on the receiver."

	anObject displayStringOn: self
]
