Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'playersTurnsSkipped',
		'nextPlayerIndex'
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

{ #category : 'checking' }
TurnManager >> checkNoTurnsToSkip [

	| activePlayer |
	activePlayer := playersTurnsSkipped at: nextPlayerIndex.
	^ activePlayer skipsTurn
]

{ #category : 'initialization' }
TurnManager >> initializePlayers: aGroup [

	playersTurnsSkipped := aGroup.
	nextPlayerIndex := 0
]

{ #category : 'play interface' }
TurnManager >> nextPlayerTurnBegins [

nextPlayerIndex := (nextPlayerIndex) \\ (playersTurnsSkipped size) + 1
]

{ #category : 'play interface' }
TurnManager >> playNextTurn [

	| activePlayer |
	self nextPlayerTurnBegins.
	activePlayer := playersTurnsSkipped at: nextPlayerIndex.
	"mientras agarre un player salteado..."
	activePlayer skipsTurn
		"ifTrue: [
			activePlayer := activePlayer turnSkipped.
			playersTurnsSkipped at: nextPlayerIndex put: activePlayer.
			aGame nextPlayerThrowsDice]"
		"ifFalse: [ aGame resetShieldsAfter2TurnsWithout ]"
		whileTrue: [
			activePlayer := activePlayer turnSkipped.
			playersTurnsSkipped at: nextPlayerIndex put: activePlayer.
			self nextPlayerTurnBegins.
			activePlayer := playersTurnsSkipped at: nextPlayerIndex].
	^ activePlayer
]

{ #category : 'play interface' }
TurnManager >> skipTurn [

	| activePlayer |
	"turn := turn + 1."
	self nextPlayerTurnBegins.
	activePlayer := playersTurnsSkipped at: nextPlayerIndex.
	"activePlayer:= activePlayer forceAShieldReset."
	
	"playersTurnsSkipped at: nextPlayerIndex put: activePlayer."
	^ activePlayer
]
