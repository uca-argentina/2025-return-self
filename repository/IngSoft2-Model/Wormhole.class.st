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
Wormhole class >> createWith: anEndpoint [

	self endpointMustBeGreaterThanOne: anEndpoint.
	^ self new initializeEffectWith: anEndpoint
]

{ #category : 'creation' }
Wormhole class >> effectProbability [
"not going to be used, special case of effect, there is only two wormholes"
^0.00
]

{ #category : 'testing' }
Wormhole class >> end: anEnd cantBeTheSameAs: anotherEnd [
"Desde la tile set"
	anEnd = anotherEnd ifTrue: [
		Error signal: 'Wormhole ends must be different tiles.' ]
]

{ #category : 'testing' }
Wormhole class >> endpointMustBeGreaterThanOne: anEndpoint [

	(anEndpoint > 1) ifFalse: [
		Error signal: 'Both ends of the Wormhole must be greater than 1.' ]
]

{ #category : 'positioning' }
Wormhole >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager [
	| distance |

	distance := aPlayer calculateDelta: endpoint.
	distance > 0 ifTrue: [ positionManager move: aPlayer forwardWith: distance ] ifFalse: [positionManager move: aPlayer backwardWith: -1*(distance)].


]

{ #category : 'testing' }
Wormhole >> endpointInside: aLength [

	^ endpoint <= aLength
]

{ #category : 'testing' }
Wormhole >> endpointSameAs: aPosition [

	^ endpoint = aPosition
]

{ #category : 'initialization' }
Wormhole >> initializeEffectWith: anEndpoint [

	endpoint := anEndpoint 
]

{ #category : 'tests - comparing' }
Wormhole >> isEndInside: aLength [

	^ aLength >= endpoint
]

{ #category : 'testing' }
Wormhole >> isWormhole [

	^ true
]
