"
An effect that makes the ship teleport to another position.
"
Class {
	#name : 'Wormhole',
	#superclass : 'Object',
	#instVars : [
		'endpoint',
		'position'
	],
	#category : 'IngSoft2-Model-Base',
	#package : 'IngSoft2-Model',
	#tag : 'Base'
}

{ #category : 'creation' }
Wormhole class >> createWith: anEndpoint in: aPosition [

	self validate: anEndpoint and: aPosition.
	^ self new initializeWith: anEndpoint and: aPosition
]

{ #category : 'validation' }
Wormhole class >> validate: anEndpoint and: aPosition [

	anEndpoint < 2 ifTrue: [
		Error signal: 'The endpoint must be at least cell number 2.' ].
	aPosition < 2 ifTrue: [
		Error signal: 'The cell must be at least number 2.' ].
	aPosition = anEndpoint ifTrue: [
		Error signal: 'The position and endpoint cant be the same.' ]
]

{ #category : 'modifying' }
Wormhole >> applyEffectOn: aShip [

	| delta |
	(aShip isIn: position) ifFalse: [ ^ aShip ].
	delta := endpoint - position.
	^ delta > 0
		  ifTrue: [ aShip moveForward: delta ]
		  ifFalse: [ aShip moveBackwards: -1 * delta ]
]

{ #category : 'initialization' }
Wormhole >> initializeWith: anEndpoint [

	endpoint := anEndpoint
]

{ #category : 'initialization' }
Wormhole >> initializeWith: anEndpoint and: aPosition [

	endpoint := anEndpoint.
	position := aPosition
]
