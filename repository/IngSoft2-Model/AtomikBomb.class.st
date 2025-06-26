Class {
	#name : 'AtomikBomb',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
AtomikBomb class >> effectProbability [

^0.02
]

{ #category : 'positioning' }
AtomikBomb >> applyEffectOn: aPlayer and: aGame [


	| aGroupOfPlayers positionManager battleManager turnManager |
	positionManager := aGame requestPositionManager: self.
	battleManager  := aGame requestBattleManager: self.
	turnManager := aGame requestTurnManager: self.
	positionManager resetPlayersPosition .
	aGroupOfPlayers := battleManager allDecreaseAShield.
	aGroupOfPlayers do: [ :player | turnManager addTwoSkipsTo: player. 
		battleManager forceAShieldResetTo: player ].

]

{ #category : 'testing' }
AtomikBomb >> isAtomikBomb [

	^ true
]
