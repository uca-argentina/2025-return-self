Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'playersTurnsSkipped'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
TurnManager class >> createWith: aGroupOfPlayers [

	| playerTurnAssociationGroup |
	playerTurnAssociationGroup := aGroupOfPlayers collect: [ :each |
		                              ShipInStandBy
			                              createWith: each id
			                              and: 0 ].

	^ self new initializePlayers: playerTurnAssociationGroup
]

{ #category : 'initialization' }
TurnManager >> initializePlayers: aGroup [

	playersTurnsSkipped := aGroup
]

{ #category : 'play interface' }
TurnManager >> playNextTurn: aGame [

	| activePlayer playerInTurnIndex |
	"turn := turn + 1."
	playerInTurnIndex := self playerInTurnIndexUsing: aGame activePlayer.
	activePlayer := playersTurnsSkipped at: playerInTurnIndex.
	"mientras agarre un player salteado..."
	activePlayer skipsTurn
		ifTrue: [
			activePlayer := activePlayer turnSkipped.
			playersTurnsSkipped at: playerInTurnIndex put: activePlayer.
			aGame nextPlayerThrowsDice]
		ifFalse: [ aGame resetShieldsAfter2TurnsWithout ]
]

{ #category : 'as yet unclassified' }
TurnManager >> playerInTurnIndexUsing: aPlayer [

^ playersTurnsSkipped findFirst: [ :each | each equals: aPlayer ]
]

{ #category : 'play interface' }
TurnManager >> skipTurn [
"VERIFICAR"
	| activePlayer |
	"turn := turn + 1."
	activePlayer := playersTurnsSkipped at: self playerInTurnIndex.
	activePlayer:= activePlayer forceAShieldReset.
	
	playersTurnsSkipped at: self playerInTurnIndex put: activePlayer.
	^ activePlayer
]
