"
A wormhole Class
"
Class {
	#name : 'Wormhole',
	#superclass : 'Object',
	#instVars : [
		'sideA',
		'sideB',
		'affectedTiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Wormhole class >> end: anEnd cantBeTheSameAs: anotherEnd [

	anEnd = anotherEnd ifTrue: [
		Error signal: 'Wormhole ends must be different tiles.' ]
]

{ #category : 'testing' }
Wormhole class >> mustBeGreaterThanOneBoth: anEnd and: anotherEnd [

	(anEnd > 1 and: anotherEnd > 1) ifFalse: [
		Error signal:
			'Both ends of the Wormhole must be greater than 1.' ]
]

{ #category : 'creation' }
Wormhole class >> oneEnd: aSideA otherEnd: aSideB [

	self mustBeGreaterThanOneBoth: aSideA and: aSideB.
	self end: aSideA cantBeTheSameAs: aSideB.
	
	^ self new initializeOneEnd: aSideA otherEnd: aSideB
]

{ #category : 'positioning' }
Wormhole >> applyEffectOn: aPlayer [

	aPlayer position = sideA ifTrue: [
		^ aPlayer advancePlayer: sideB-sideA ].
	aPlayer position = sideB ifTrue: [
		^ aPlayer advancePlayer: sideA-sideB ].
	^ aPlayer
]

{ #category : 'tests - comparing' }
Wormhole >> areEndsInside: aLength [

	^ aLength >= sideA and: aLength >= sideB
]

{ #category : 'initialization' }
Wormhole >> initializeOneEnd: aSide otherEnd: anotherSide [

	sideA := aSide.
	sideB := anotherSide.
	affectedTiles := { sideA. sideB. }.

]
