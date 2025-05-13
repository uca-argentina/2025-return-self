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
	^ self new initializeWithLength: maxLength with: noEffectObject
]

{ #category : 'Creation' }
Board class >> withLenght: maxLength and: wormhole [

	^ self new initializeWithLength: maxLength with:wormhole
]

{ #category : 'as yet unclassified' }
Board >> checkEffects: aPosition [
 (aWormhole isAffectedTiles: aPosition) ifTrue: [ ^aWormhole ].
^NoEffect new.
]

{ #category : 'initialization' }
Board >> initializeWithLength: maxLength with: wormhole [

	aLength := maxLength.
	aWormhole := wormhole. 
]

{ #category : 'getters' }
Board >> lenght [

	^ aLength
]

{ #category : 'as yet unclassified' }
Board >> wormhole [
 ^aWormhole
]
