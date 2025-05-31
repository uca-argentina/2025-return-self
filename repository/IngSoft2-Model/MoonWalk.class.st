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
MoonWalk class >> initializeInTile: aTile withDebuff: aDebuff andAGroupOfPlayers: aGroupOfPlayers [ 
	^self new initializeOnTile: aTile withDebuff: aDebuff andAGroupOfPlayers: aGroupOfPlayers .
]

{ #category : 'as yet unclassified' }
MoonWalk class >> initializeOnTile: aTile [ 
	^self new initializeOnTile: aTile.
]

{ #category : 'positioning' }
MoonWalk >> applyEffectOn: aGroupOfPlayers onIndex: anIndex [
	| playersToApplyEffect unaffectedPlayer|
	unaffectedPlayer:= aGroupOfPlayers at: anIndex.
	unaffectedPlayer position = tile ifTrue: [
	playersToApplyEffect := aGroupOfPlayers collect: [:player | player goBackTiles: debuff ].
	 (playersToApplyEffect at: anIndex put: unaffectedPlayer ).
	^playersToApplyEffect.
	].
^aGroupOfPlayers 
	
]

{ #category : 'initialization' }
MoonWalk >> initializeOnTile: aTile [
	tile := aTile.
	debuff := 5.
]

{ #category : 'as yet unclassified' }
MoonWalk >> initializeOnTile: aTile withDebuff: aDebuff andAGroupOfPlayers: aGroupOfPlayers [
	tile := aTile.
	debuff := aDebuff.
	setOfPlayers := aGroupOfPlayers.
]

{ #category : 'initialization' }
MoonWalk >> tiles [
 ^{tile}
]
