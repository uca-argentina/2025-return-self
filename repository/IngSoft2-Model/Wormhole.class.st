"
A wormhole Class
"
Class {
	#name : 'Wormhole',
	#superclass : 'Effect',
	#instVars : [
		'endpoint'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Wormhole class >> effectProbability [
"not going to be used, special case of effect, there is only two wormholes"
^0.00
]

{ #category : 'testing' }
Wormhole class >> end: anEnd cantBeTheSameAs: anotherEnd [

	anEnd = anotherEnd ifTrue: [
		Error signal: 'Wormhole ends must be different tiles.' ]
]

{ #category : 'testing' }
Wormhole class >> mustBeGreaterThanOneBoth: anEnd and: anotherEnd [

	(anEnd > 1 and: anotherEnd > 1) ifFalse: [
		Error signal: 'Both ends of the Wormhole must be greater than 1.' ]
]

{ #category : 'creation' }
Wormhole class >> oneEnd: aSideA otherEnd: aSideB [

	self mustBeGreaterThanOneBoth: aSideA and: aSideB.
	self end: aSideA cantBeTheSameAs: aSideB.

	^ self new initializeOneEnd: aSideA otherEnd: aSideB
]

{ #category : 'positioning' }
Wormhole >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager [
	| distance |

	distance := endpoint - tile.
	distance > 0 ifTrue: [ positionManager move: aPlayer forwardWith: distance ] ifFalse: [positionManager move: aPlayer backwardWith: -1*(distance)].


]

{ #category : 'tests - comparing' }
Wormhole >> areEndsInside: aLength [

	^ aLength >= tile and: aLength >= endpoint 
]

{ #category : 'initialization' }
Wormhole >> initializeOneEnd: aSide otherEnd: anotherSide [

	tile := aSide.
	endpoint := anotherSide
]

{ #category : 'initialization' }
Wormhole >> tiles [ 

	^{ tile . endpoint }
]
