"
A board class
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'aLength',
		'aWormhole'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'Creation' }
Board class >> withLenght: maxLength [

	^ self new initializeWithLength: maxLength
]

{ #category : 'Creation' }
Board class >> withLenght: maxLength withWormhole: wormhole [

	^ self new initializeWithLength: maxLength withWormhole:wormhole
]

{ #category : 'initialization' }
Board >> initializeWithLength: maxLength [

	aLength := maxLength.
	aWormhole := Wormhole notSetted.
]

{ #category : 'initialization' }
Board >> initializeWithLength: maxLength withWormhole: wormhole [

	aLength := maxLength.
	aWormhole := wormhole. 
]

{ #category : 'getters' }
Board >> lenght [

	^ aLength
]

{ #category : 'initialization' }
Board >> movePlayer: player thisManySteps: steps [
	^(aWormhole suckInIfEncounter: player), (player move: steps).
]

{ #category : 'as yet unclassified' }
Board >> wormhole [
 ^aWormhole
]
