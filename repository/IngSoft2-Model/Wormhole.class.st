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

	^ 0
]

{ #category : 'testing' }
Wormhole class >> endpointMustBeGreaterThanOne: anEndpoint [

	anEndpoint > 1 ifFalse: [
		Error signal: 'Both ends of the Wormhole must be greater than 1.' ]
]

{ #category : 'positioning' }
Wormhole >> applyEffectOn: aPlayer and: aGame [

	aGame move: aPlayer toTile: endpoint
]

{ #category : 'testing' }
Wormhole >> assertCanBeAt: aTileNumber onBoardOf: aNumberOfTiles [

	endpoint = aTileNumber ifTrue: [
		Error signal: 'Wormhole ends must be different tiles.' ].
	endpoint <= aNumberOfTiles ifFalse: [
		Error signal: 'Wormhole endpoint must be inside.' ]
]

{ #category : 'initialization' }
Wormhole >> initializeEffectWith: anEndpoint [

	endpoint := anEndpoint
]
