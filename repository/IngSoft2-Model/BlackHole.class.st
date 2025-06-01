Class {
	#name : 'BlackHole',
	#superclass : 'Effect',
	#instVars : [
		'debuff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
BlackHole class >> effectProbability [

^0.20
]

{ #category : 'positioning' }
BlackHole >> applyEffectOn: aGroupOfPlayers triggeredByPlayerAt: anIndex [
	| aPlayer |
	aPlayer := aGroupOfPlayers at: anIndex.
"	aPlayer position = tile ifTrue: ["
		aPlayer := aPlayer goBackTiles: debuff.
		 (aGroupOfPlayers at: anIndex put: aPlayer).
"		]."
	^aGroupOfPlayers
	
]

{ #category : 'initialization' }
BlackHole >> initializeOnTile: aTile [
	tile := aTile.
	debuff := 4.
]
