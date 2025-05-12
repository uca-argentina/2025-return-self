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
Dice class >> faces: numberOfFaces [

	^ self new initializeNumberOfFaces: numberOfFaces
]

{ #category : 'accessing' }
Dice >> initializeNumberOfFaces: number [

	numberOfFaces := number
]

{ #category : 'accessing' }
Dice >> throw [

	^ Random new nextIntegerBetween: 1 and: numberOfFaces
]
