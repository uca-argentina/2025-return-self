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

{ #category : 'as yet unclassified' }
AtomikBomb class >> initializeOnTile: aTile [ 
	^self new initializeOnTile: aTile .
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
AtomikBomb >> initializeOnTile: aTile [
	tile := aTile.


]

{ #category : 'initialization' }
AtomikBomb >> tiles [
 ^{tile}

	
]
