"
A simple importer from my old format in XML. 
Used in comments of other classes.

The following will load the latest file named BD.xxx.xml in the current working directory.
```
CXXMLImporter new import
```

```
CXCompactTableLatexPrinter new
	setBase: (CXBase stefBase addNewSerieFromCollection: CXXMLImporter stefBds);
	setWorkingDirectoryFromBase;
	save.
```
"
Class {
	#name : 'CXXMLImporter',
	#superclass : 'Object',
	#instVars : [
		'directory'
	],
	#category : 'Comix-Migration Support',
	#package : 'Comix',
	#tag : 'Migration Support'
}

{ #category : 'examples' }
CXXMLImporter class >> importStefBdsAsPlainList [
	<script>
	
	| bds |
	bds := self stefImporter import.
	bds inspect. 
	^ bds

	
]

{ #category : 'examples' }
CXXMLImporter class >> stefImporter [

	<sampleInstance>
	^ self new
		  directory: '/Users/ducasse/Workspace/FirstCircle/Working/SF/sf/Comix/' asFileReference;
		  yourself
]

{ #category : 'utils' }
CXXMLImporter >> compileAccessorsNamed: aName [
	CXItem 
		compile: (self setterBodyFor: aName)
		classified: 'accessing'.
	CXItem 
		compile: (self getterBodyFor: aName)
		classified: 'accessing'.	
	
]

{ #category : 'utils' }
CXXMLImporter >> compileSetterNamed: aName [

	CXItem 
		compile: (self setterBodyFor: aName)
		classified: 'accessing'
]

{ #category : 'accessing' }
CXXMLImporter >> directory [

	^ directory
]

{ #category : 'accessing' }
CXXMLImporter >> directory: aFileReference [

	directory := aFileReference
]

{ #category : 'utils' }
CXXMLImporter >> getterBodyFor: aName [

	^ (String streamContents: [:s |
						s << aName.
						s cr.
						s tab.
						s << '^ ' << aName.
						s cr.
						])
	
]

{ #category : 'importing' }
CXXMLImporter >> import [
	"self new import"

	^ self importFileName: (self directory resolve: (self workingDirectory lastFileFor: 'BD' extension: 'xml')) fullName
]

{ #category : 'importing' }
CXXMLImporter >> importFileName: aString [
	"self new importFileName: 'BD.322.xml'"
	| p col |
	col := OrderedCollection new.
	p := XMLDOMParser onFileNamed: aString.
	p parseDocument elements first elements do: [ :each | 
		| bd | 
		bd := CXItem new.
		col add: bd.
		each attributeNamesAndValuesDo: [ :attName :value | 
			bd perform: ('import', attName capitalized , ':') asSymbol with: value
			"[ bd perform: attName with: value ] 
					on: MessageNotUnderstood 
					do: [ :ex | self compileAccessorsNamed: attName ]" ]
		].
	^ col
]

{ #category : 'initialization' }
CXXMLImporter >> initialize [ 
	super initialize.
	directory := FileSystem workingDirectory
]

{ #category : 'utils' }
CXXMLImporter >> setterBodyFor: aName [

	^ (String streamContents: [:s |
						s << aName.
						s << ': aValue'.
						s cr.
						s tab.
						s << aName.
						s << ' := aValue'.
						s cr.
						])
	
]

{ #category : 'accessing' }
CXXMLImporter >> workingDirectory [
	self deprecated: 'use directory' transformWith: '`@rec workingDirectory' -> '`@rec directory'. 
	^ directory
]

{ #category : 'accessing' }
CXXMLImporter >> workingDirectory: aFileReference [
	self deprecated: 'use directory:' transformWith: '`@rec workingDirectory: `@dir' -> '`@rec directory: `@dir'. 
	directory := aFileReference
]
