Class {
	#name : 'Wormhole',
	#superclass : 'Object',
	#instVars : [
		'sideA',
		'sideB'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Wormhole class >> oneEnd: sideA otherEnd: sideB [

	^ self new initializeOneEnd: sideA otherEnd: sideB
]

{ #category : 'initialization' }
Wormhole >> initializeOneEnd: aSide otherEnd: anotherSide [

	sideA := aSide.
	sideB := anotherSide
]

{ #category : 'as yet unclassified' }
Wormhole >> suckInIfEncounter: player [
	(player position = sideA) ifTrue:[player teleportTo: sideB]
	ifFalse:[
		(player position = sideB) ifTrue:[player teleportTo: sideA].
	].
]
