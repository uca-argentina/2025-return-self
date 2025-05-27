"
A dice Object
"
Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFaces'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Dice class >> faces: aNumberOfFaces [

	self facesHasToBeGreaterThanTwo: aNumberOfFaces.

	^ self new initializeNumberOfFaces: aNumberOfFaces
]

{ #category : 'testing' }
Dice class >> facesHasToBeGreaterThanTwo: aNumberOfFaces [

	aNumberOfFaces > 2 ifFalse: [
		Error signal: 'The number of faces must be greater than two.' ]
]

{ #category : 'initialization' }
Dice >> initializeNumberOfFaces: aNumberOfFaces [

	numberOfFaces := aNumberOfFaces
]

{ #category : 'accessing' }
Dice >> throw [

	^ Random new nextIntegerBetween: 1 and: numberOfFaces
]
