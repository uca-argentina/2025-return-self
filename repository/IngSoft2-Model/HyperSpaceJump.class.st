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
HyperSpaceJump class >> effectProbability [

^0.20
]

{ #category : 'initialization' }
HyperSpaceJump class >> initializeOnTile: aTile [ 
 ^ self new initializeOnTile: aTile 
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

{ #category : 'initialization' }
HyperSpaceJump >> initializeOnTile: aTile [ 
	tile := aTile.
	buff := 4.

]

{ #category : 'initialization' }
HyperSpaceJump >> tiles [
 ^tile
]
