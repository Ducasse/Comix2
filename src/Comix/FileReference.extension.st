Extension { #name : 'FileReference' }

{ #category : '*Comix' }
FileReference >> lastFileFor: baseFileName extension: extension [
  "Assumes a file is named using a version number encoded as '.' followed by digits
  preceding the file extension, e.g., games.22.ston
  Answer the file name with the largest number.
  If a version number is not found, raises an error"

  "FileSystem workingDirectory lastFileFor: 'games' extension: 'ston'"

    | files |
    files := self childrenMatching: baseFileName , '.*.' , extension.
    files ifEmpty: [ ^ self error: 'No file with number pattern' ].
    ^ (files asSortedCollection: [ :a :b | ((a basename splitOn: $.) at: 2) asNumber < 
														((b basename splitOn: $.)  at: 2) asNumber ]) last

]
