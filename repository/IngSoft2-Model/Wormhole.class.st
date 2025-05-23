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

{ #category : 'creation' }
Wormhole class >> oneEnd: aSideA otherEnd: aSideB [

	self positionOfWormholeTileHasToBeGreaterThanOneBoth: aSideA and: aSideB.
	
	^ self new initializeOneEnd: aSideA otherEnd: aSideB
]

{ #category : 'testing' }
Wormhole class >> positionOfWormholeTileHasToBeGreaterThanOneBoth: anEnd and: anotherEnd [

	(anEnd > 1 and: anotherEnd > 1) ifFalse: [ Error signal: 'No endpoint of the wormhole can be lower or equal to 1.' ]
]

{ #category : 'positioning' }
Wormhole >> applyEffectOn: aPlayer [

	aPlayer position = sideA ifTrue: [
		^ Player named: aPlayer name withPosition: sideB ].
	aPlayer position = sideB ifTrue: [
		^ Player named: aPlayer name withPosition: sideA ].
	^ aPlayer
]

{ #category : 'initialization' }
Wormhole >> initializeOneEnd: aSide otherEnd: anotherSide [

	sideA := aSide.
	sideB := anotherSide.
	affectedTiles := { sideA. sideB. }.

]

{ #category : 'testing' }
Wormhole >> isAffectedTiles: aTile [ 
	^affectedTiles includes:aTile
]
