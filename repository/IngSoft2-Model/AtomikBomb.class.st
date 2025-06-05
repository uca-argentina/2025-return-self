Class {
	#name : 'AtomikBomb',
	#superclass : 'Effect',
	#instVars : [
		'setOfPlayers'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AtomikBomb class >> effectProbability [

^0.02
]

{ #category : 'positioning' }
AtomikBomb >> applyEffectOn: aGroupOfPlayers triggeredByPlayerAt: anIndex [
"VERIFICAR"
	| playersToApplyEffect aPlayer |
	aPlayer := aGroupOfPlayers at: anIndex.
	"aPlayer position = tile ifTrue: ["
	playersToApplyEffect := aGroupOfPlayers collect: [ :player |
		                        player goToFirstTile loseShield ].
	^ playersToApplyEffect
	"]."
	"^aGroupOfPlayers "
]
