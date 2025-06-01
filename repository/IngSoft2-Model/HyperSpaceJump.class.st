Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Effect',
	#instVars : [
		'buff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperSpaceJump class >> effectProbability [

^0.20
]

{ #category : 'positioning' }
HyperSpaceJump >> applyEffectOn: aGroupOfPlayers triggeredByPlayerAt: anIndex [ 
		| aPlayer |
	aPlayer := aGroupOfPlayers at: anIndex.
"	aPlayer position = tile ifTrue: ["
		aPlayer := aPlayer advanceTiles: buff.
		aPlayer := aPlayer loseShield.
		 (aGroupOfPlayers at: anIndex put: aPlayer).
"		]."
	^aGroupOfPlayers 
	
]

{ #category : 'initialization' }
HyperSpaceJump >> initializeOnTile: aTile [
	tile := aTile.
	buff := 4.

]
