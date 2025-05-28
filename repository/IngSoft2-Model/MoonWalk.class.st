Class {
	#name : 'MoonWalk',
	#superclass : 'Effect',
	#instVars : [
		'tile',
		'debuff',
		'setOfPlayers'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
MoonWalk class >> initializeInTile: aTile withDebuff: aDebuff andSetOfPlayers: aSetOFPlayers [ 
	^self new initializeOnTile: aTile withDebuff: aDebuff andSetOfPlayers: aSetOFPlayers .
]

{ #category : 'positioning' }
MoonWalk >> applyEffectOn: aSetOfPlayers onIndex: anIndex [
	| playersToApplyEffect unaffectedPlayer|
	unaffectedPlayer:= aSetOfPlayers at: anIndex.
	unaffectedPlayer position = tile ifTrue: [
	playersToApplyEffect := aSetOfPlayers collect: [:player | player goBackTiles: debuff ].
	 (playersToApplyEffect at: anIndex put: unaffectedPlayer ).
	^playersToApplyEffect.
	].
^aSetOfPlayers 
	
]

{ #category : 'positioning' }
MoonWalk >> applyEffectOn: aPlayer onTurn: aTurn [
	| playersToApplyEffect |
	
	aPlayer position = tile ifTrue: [
	playersToApplyEffect := setOfPlayers copyWithout: aPlayer .
	playersToApplyEffect do: [:player | player goBackTiles: debuff ].
	].
	^aPlayer .
]
