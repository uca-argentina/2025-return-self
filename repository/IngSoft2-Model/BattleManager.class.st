Class {
	#name : 'BattleManager',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BattleManager >> engagePlayer: player withDice: setOfDie against: aGroupOfPlayers [
   |playersToEngage|
	playersToEngage := self selectPlayersInSamePositionAs: player from: aGroupOfPlayers.
	
	(player position = 1)  ifTrue:[^aGroupOfPlayers ].
	playersToEngage size >= 2 ifTrue: ["si encuentra 2 o mas en la misma posicion"
		  (setOfDie throw > setOfDie throw) ifTrue: ["gana el primero"
			  playersToEngage at:2 put: (playersToEngage at:2 ) loseBattle.
			] ifFalse: ["gana el segundo"
			  playersToEngage at:1 put: (playersToEngage at:1 ) loseBattle.
			].
		] .
	^ self insertPlayers: playersToEngage InsideList: aGroupOfPlayers .
]

{ #category : 'as yet unclassified' }
BattleManager >> insertPlayers: playersToEngage InsideList: aGroupOfPlayers [
	
	playersToEngage do:[:justBattled |
		aGroupOfPlayers at:(aGroupOfPlayers findFirst:[:each | each name = justBattled  name]) put: justBattled .
		].
	^aGroupOfPlayers 
]

{ #category : 'as yet unclassified' }
BattleManager >> selectPlayersInSamePositionAs: player from: aGroupOfPlayers [
	^aGroupOfPlayers select:[:each| each position = player position].
]
