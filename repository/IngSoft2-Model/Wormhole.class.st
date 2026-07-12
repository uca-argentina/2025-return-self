"
An effect that makes the ship teleport to another position.
"
Class {
	#name : 'Wormhole',
	#superclass : 'Object',
	#instVars : [
		'lowEndpoint',
		'greatEndpoint'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Wormhole class >> from: lowestEndpoint to: greatestEndpoint [

	self validate: lowestEndpoint and: greatestEndpoint.
	^ self new initializeWith: lowestEndpoint and: greatestEndpoint
]

{ #category : 'validation' }
Wormhole class >> validate: lowestEndpoint and: greatestEndpoint [

	greatestEndpoint <= lowestEndpoint ifTrue: [
		Error signal:
			'Greatest endpoint must be greater than lowest endpoint.' ].
	lowestEndpoint < 2 ifTrue: [
		Error signal: 'Lowest endpoint must be at least number 2.' ]
]

{ #category : 'modifying' }
Wormhole >> applyEffectOn: aShip [

	| delta |
	(self checkTriggersBy: aShip) ifFalse: [ ^ aShip ].

	delta := greatEndpoint - lowEndpoint.

	^ (aShip isIn: lowEndpoint)
		  ifTrue: [ aShip moveForward: delta ]
		  ifFalse: [ aShip moveBackwards: delta ]
]

{ #category : 'events-triggering' }
Wormhole >> checkTriggersBy: aShip [

	^ (aShip isIn: lowEndpoint) or: (aShip isIn: greatEndpoint)
]

{ #category : 'initialization' }
Wormhole >> initializeWith: lowestEndpoint and: greatestEndpoint [

	lowEndpoint := lowestEndpoint.
	greatEndpoint := greatestEndpoint
]
