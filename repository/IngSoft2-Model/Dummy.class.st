Class {
	#name : 'Dummy',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Dummy >> isDummy [
	"Returns true, always"
	"Holaa"

	^ true
]

{ #category : 'testing' }
Dummy >> isDummy2 [
	"Testing PR"

	^ false
]
