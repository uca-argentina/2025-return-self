Class {
	#name : 'MoonWalk',
	#superclass : 'Effect',
	#instVars : [
		'debuff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
MoonWalk class >> createOnTile: aTile [
	"ver en la generacion automatica"
	^self new initializeOnTile: aTile withDebuff: 4.
]

{ #category : 'as yet unclassified' }
MoonWalk class >> createOnTile: aTile withDebuff: aDebuff [
	^self new initializeOnTile: aTile withDebuff: aDebuff.
]

{ #category : 'initialization' }
MoonWalk class >> effectProbability [

^0.10
]

{ #category : 'positioning' }
MoonWalk >> applyEffectOn: aGroupOfPlayers triggeredByPlayerAt: anIndex [

	| playersToApplyEffect unaffectedPlayer |
	unaffectedPlayer := aGroupOfPlayers at: anIndex.
	"	unaffectedPlayer position = tile ifTrue: ["
	playersToApplyEffect := aGroupOfPlayers collect: [ :player |
		                        player goBackTiles: debuff ].
	playersToApplyEffect at: anIndex put: unaffectedPlayer.
	^ playersToApplyEffect
	"	].
^aGroupOfPlayers"
]

{ #category : 'as yet unclassified' }
MoonWalk >> initializeOnTile: aTile withDebuff: aDebuff [
	tile := aTile.
	debuff := aDebuff.
]
