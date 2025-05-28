Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Effect',
	#instVars : [
		'tile',
		'buff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperSpaceJump class >> initializeInTile: aTile withBuff: aBuff [
 ^ self new initializeInTile: aTile withBuff: aBuff
]

{ #category : 'positioning' }
HyperSpaceJump >> applyEffectOn: aSetOfPlayers onIndex: anIndex [ 
		| aPlayer |
	aPlayer := aSetOfPlayers at: anIndex.
	aPlayer position = tile ifTrue: [
		aPlayer := aPlayer advanceTiles: buff.
		aPlayer := aPlayer loseShield.
		 (aSetOfPlayers at: anIndex put: aPlayer).
		].
	^aSetOfPlayers 
	
]

{ #category : 'initialization' }
HyperSpaceJump >> initializeInTile: aTile withBuff: aBuff [
	tile := aTile.
	buff := aBuff.

]
