Class {
	#name : 'BattleManager',
	#superclass : 'Object',
	#instVars : [
		'players'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BattleManager class >> createWith: aGroupOfPlayers [
^self new initializeBattleManagerWith: aGroupOfPlayers
]

{ #category : 'as yet unclassified' }
BattleManager >> ifBattleThenEngage: aPlayer using: someDice [
   |playersToEngage |
	(aPlayer position = 1)  ifTrue:[^players ].
	playersToEngage := self selectPlayersInSamePositionAs: aPlayer.
	
	playersToEngage size >= 2 ifTrue: ["si encuentra 2 o mas en la misma posicion"
		  (someDice throw > someDice throw) ifTrue: ["gana el primero"
			  playersToEngage at:2 put: (playersToEngage at:2 ) loseBattle.
			] ifFalse: ["gana el segundo"
			  playersToEngage at:1 put: (playersToEngage at:1 ) loseBattle.
			].
		] .
	self updateFightingPlayersWith: playersToEngage.
	^players 
]

{ #category : 'initialization' }
BattleManager >> initializeBattleManagerWith: aGroupOfPlayers [

players := aGroupOfPlayers 
]

{ #category : 'as yet unclassified' }
BattleManager >> selectPlayersInSamePositionAs: player [
	^players select:[:each| each position = player position].
]

{ #category : 'as yet unclassified' }
BattleManager >> updateFightingPlayersWith: playersToEngage [

	playersToEngage do:[:justBattled |
		players at:(players findFirst:[:each | each name = justBattled  name]) put: justBattled .
		].
	
	
]

{ #category : 'updating' }
BattleManager >> updateWith: aGroupOfPlayers [

^self class createWith: aGroupOfPlayers
]
