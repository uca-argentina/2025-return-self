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
AtomikBomb >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager [

	| aGroupOfPlayers |
	positionManager resetPlayersPosition .
	aGroupOfPlayers := battleManager allDecreaseAShield.
	aGroupOfPlayers do: [ :player | turnManager addTwoSkipsTo: player. 
		battleManager forceAShieldResetTo: player ].

]
