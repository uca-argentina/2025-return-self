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

{ #category : 'as yet unclassified' }
Board class >> withLenght: maxLength [ 
	| noEffectObject |
	noEffectObject := NoEffect new.
	^ self new initializeWithLength: maxLength withWormhole: noEffectObject
]

{ #category : 'Creation' }
Board class >> withLenght: maxLength and: wormhole [

	^ self new initializeWithLength: maxLength withWormhole:wormhole
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
	^(aWormhole applyEffect: player), (player move: steps).
]

{ #category : 'as yet unclassified' }
Board >> wormhole [
 ^aWormhole
]
