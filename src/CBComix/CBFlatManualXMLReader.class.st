"
I am a minimal reader for the flat XML format of the collection (no external XML parser is needed).
I return, for each element, an association tagName -> Dictionary of attributes. Nesting and text are ignored.
"
Class {
	#name : 'CBFlatManualXMLReader',
	#superclass : 'Object',
	#category : 'CBComix-ImportExport',
	#package : 'CBComix',
	#tag : 'ImportExport'
}

{ #category : 'encoding' }
CBFlatManualXMLReader class >> decode: aString [

	^ ((((aString copyReplaceAll: '&quot;' with: '"') copyReplaceAll: '&apos;' with: '''') copyReplaceAll: '&lt;' with: '<')
		   copyReplaceAll: '&gt;'
		   with: '>') copyReplaceAll: '&amp;' with: '&'
]

{ #category : 'encoding' }
CBFlatManualXMLReader class >> encode: aString [

	^ (((aString copyReplaceAll: '&' with: '&amp;') copyReplaceAll: '<' with: '&lt;') copyReplaceAll: '>' with: '&gt;')
		  copyReplaceAll: '"'
		  with: '&quot;'
]

{ #category : 'reading' }
CBFlatManualXMLReader >> elementsIn: aString [

	| elements stream |
	elements := OrderedCollection new.
	stream := aString readStream.
	[ stream skipTo: $< ] whileTrue: [
			('?/!' includes: stream peek)
				ifTrue: [ stream skipTo: $> ]
				ifFalse: [ elements add: (self readElementFrom: stream) ] ].
	^ elements
]

{ #category : 'private' }
CBFlatManualXMLReader >> isNameEnd: aCharacter [

	^ aCharacter isSeparator or: [ '=/>' includes: aCharacter ]
]

{ #category : 'private' }
CBFlatManualXMLReader >> readElementFrom: aStream [

	| tagName attributes |
	tagName := self readNameFrom: aStream.
	attributes := Dictionary new.
	[
		aStream skipSeparators.
		aStream atEnd or: [ '/>' includes: aStream peek ] ] whileFalse: [
			| key quote |
			key := self readNameFrom: aStream.
			key ifEmpty: [ aStream next ] ifNotEmpty: [
					aStream skipSeparators.
					aStream next.
					aStream skipSeparators.
					quote := aStream next.
					attributes at: key put: (self class decode: (aStream upTo: quote)) ] ].
	aStream skipTo: $>.
	^ tagName -> attributes
]

{ #category : 'private' }
CBFlatManualXMLReader >> readNameFrom: aStream [

	^ String streamContents: [ :out |
		  [ aStream atEnd or: [ self isNameEnd: aStream peek ] ] whileFalse: [ out nextPut: aStream next ] ]
]
