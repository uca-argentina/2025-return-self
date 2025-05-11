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

{ #category : 'as yet unclassified' }
Wormhole class >> oneEnd: sideA otherEnd: sideB [
	|wormhole|
	wormhole := self new.
	wormhole oneEnd: sideA.
	wormhole otherEnd: sideB.
	^wormhole .
]

{ #category : 'as yet unclassified' }
Wormhole >> oneEnd: side [
	sideA:= side.
]

{ #category : 'as yet unclassified' }
Wormhole >> otherEnd: side [
	sideB:= side.
]

{ #category : 'as yet unclassified' }
Wormhole >> suckInIfEncounter: player [
	(player position = sideA) ifTrue:[player teleportTo: sideB]
	ifFalse:[
		(player position = sideB) ifTrue:[player teleportTo: sideA].
	].
]
