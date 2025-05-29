Class {
	#name : 'AtomikBomb',
	#superclass : 'Effect',
	#instVars : [
		'tile',
		'setOfPlayers'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AtomikBomb class >> effectProbability [

^0.02
]

{ #category : 'initialization' }
AtomikBomb class >> initializeInTile: aTile andSetOfPlayers: aSetOFPlayers [ 
	^self new initializeOnTile: aTile andSetOfPlayers: aSetOFPlayers .
]

{ #category : 'positioning' }
AtomikBomb >> applyEffectOn: aSetOfPlayers onIndex: anIndex [

	| playersToApplyEffect aPlayer |
	aPlayer:= aSetOfPlayers at: anIndex.
	aPlayer position = tile ifTrue: [
	playersToApplyEffect := aSetOfPlayers collect: [:player | (player goToFirstTile) loseShield ].
	^playersToApplyEffect.
	].
^aSetOfPlayers 

	
]

{ #category : 'initialization' }
AtomikBomb >> initializeOnTile: aTile andSetOfPlayers: aSetOfPlayers [
	tile := aTile.

	setOfPlayers := aSetOfPlayers.
]

{ #category : 'positioning' }
AtomikBomb >> tiles [
 ^tile

	
]
