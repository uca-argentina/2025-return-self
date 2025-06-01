Class {
	#name : 'MoonWalk',
	#superclass : 'Effect',
	#instVars : [
		'debuff',
		'setOfPlayers'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MoonWalk class >> createInTile: aTile withDebuff: aDebuff andAGroupOfPlayers: aGroupOfPlayers [ 
	^self new initializeOnTile: aTile withDebuff: aDebuff andAGroupOfPlayers: aGroupOfPlayers .
]

{ #category : 'initialization' }
MoonWalk class >> effectProbability [

^0.10
]

{ #category : 'positioning' }
MoonWalk >> applyEffectOn: aGroupOfPlayers triggeredByPlayerAt: anIndex [
	| playersToApplyEffect unaffectedPlayer|
	unaffectedPlayer:= aGroupOfPlayers at: anIndex.
	unaffectedPlayer position = tile ifTrue: [
	playersToApplyEffect := aGroupOfPlayers collect: [:player | player goBackTiles: debuff ].
	 (playersToApplyEffect at: anIndex put: unaffectedPlayer ).
	^playersToApplyEffect.
	].
^aGroupOfPlayers 
	
]

{ #category : 'as yet unclassified' }
MoonWalk >> initializeOnTile: aTile withDebuff: aDebuff andAGroupOfPlayers: aGroupOfPlayers [
	tile := aTile.
	debuff := aDebuff.
	setOfPlayers := aGroupOfPlayers.
]
