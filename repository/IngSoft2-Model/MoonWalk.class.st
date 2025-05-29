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
MoonWalk class >> effectProbability [

^0.10
]

{ #category : 'as yet unclassified' }
MoonWalk class >> initializeInTile: aTile withDebuff: aDebuff andSetOfPlayers: aSetOFPlayers [ 
	^self new initializeOnTile: aTile withDebuff: aDebuff andSetOfPlayers: aSetOFPlayers .
]

{ #category : 'as yet unclassified' }
MoonWalk class >> initializeOnTile: aTile [ 
	^self new initializeOnTile: aTile.
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

{ #category : 'initialization' }
MoonWalk >> initializeOnTile: aTile [
	tile := aTile.
	debuff := 5.
]

{ #category : 'initialization' }
MoonWalk >> initializeOnTile: aTile withDebuff: aDebuff andSetOfPlayers: aSetOfPlayers [
	tile := aTile.
	debuff := aDebuff.
	setOfPlayers := aSetOfPlayers.
]

{ #category : 'initialization' }
MoonWalk >> tiles [
 ^tile
]
