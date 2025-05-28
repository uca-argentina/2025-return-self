Class {
	#name : 'BattleManager',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BattleManager >> engagePlayer: player withDice: setOfDie against: setOfPlayers [
   |playersToEngage|
	playersToEngage := setOfPlayers select:[:each| each position = player position].
	playersToEngage size >= 2 ifTrue: ["si encuentra 2 o mas en la misma posicion"
		  setOfDie throw > setOfDie throw ifTrue: ["gana el primero"
			  playersToEngage at:2 put: (playersToEngage at:2 ) loseBattle.
			] ifFalse: ["gana el segundo"
			  playersToEngage at:1 put: (playersToEngage at:1 ) loseBattle.
			].
		] .
	playersToEngage do:[:justBattled |
		setOfPlayers at:(setOfPlayers findFirst:[:each | each name = justBattled  name]) put: justBattled .
		].
	^ setOfPlayers 
]
