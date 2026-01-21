"
A die
"
Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'faces'
	],
	#category : 'IngSoft2-Model-Base',
	#package : 'IngSoft2-Model',
	#tag : 'Base'
}

{ #category : 'creation' }
Die class >> createWith: aNumberOfFaces [

	self validate: aNumberOfFaces.
	^ self new initializeWith: aNumberOfFaces
]

{ #category : 'validation' }
Die class >> validate: aNumberOfFaces [

	aNumberOfFaces < 4 ifTrue: [
		Error signal: 'Minimum amount of faces should be 4.' ]
]

{ #category : 'initialization' }
Die >> initializeWith: aNumberOfFaces [

	faces := aNumberOfFaces
]

{ #category : 'calculating' }
Die >> throw [

	^ (1 to: faces) atRandom
]
