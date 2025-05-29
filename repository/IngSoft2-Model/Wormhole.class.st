"
A wormhole Class
"
Class {
	#name : 'Wormhole',
	#superclass : 'Effect',
	#instVars : [
		'sideA',
		'sideB'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Wormhole class >> effectProbability [

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
Wormhole >> applyEffectOn: aSetOfPlayers onIndex: anIndex [
	| player distance newPlayer |
	player := aSetOfPlayers at: anIndex.

	(player position = sideA or: [ player position = sideB ]) ifFalse: [
		^ aSetOfPlayers ].

	distance := sideB - sideA.
	newPlayer :=player position = sideA ifTrue: [ player advanceTiles: distance ] ifFalse: [player goBackTiles: distance].

	aSetOfPlayers
		at: anIndex
		put: newPlayer.

	^ aSetOfPlayers

]

{ #category : 'tests - comparing' }
Wormhole >> areEndsInside: aLength [

	^ aLength >= sideA and: aLength >= sideB
]

{ #category : 'initialization' }
Wormhole >> initializeOneEnd: aSide otherEnd: anotherSide [

	sideA := aSide.
	sideB := anotherSide
]
