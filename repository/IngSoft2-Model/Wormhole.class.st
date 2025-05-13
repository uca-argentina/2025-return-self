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
Wormhole class >> oneEnd: sideA otherEnd: sideB [

	^ self new initializeOneEnd: sideA otherEnd: sideB
]

{ #category : 'positioning' }
Wormhole >> applyEffectOn: aPlayer [

	"aPlayer position = sideA ifTrue: [
		^ self passThrough: aPlayer enter: sideA exit: sideB ].
	aPlayer position = sideB ifTrue: [
		^ self passThrough: aPlayer enter: sideB exit: sideA ].
	^ ''"
	aPlayer position = sideA ifTrue: [ ^ Player named: (aPlayer name) withPosition: sideB ].
	aPlayer position = sideB ifTrue: [ ^ Player named: (aPlayer name) withPosition: sideA ].
	^aPlayer.
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

{ #category : 'as yet unclassified' }
Wormhole >> passThrough: player enter: enter exit: exit [

	player teleportTo: exit.
	^ player name,' entered wormhole on ',enter asString,' and came out from ',exit asString,' - Then '.
]
