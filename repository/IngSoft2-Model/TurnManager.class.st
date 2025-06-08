Class {
	#name : 'TurnManager',
	#superclass : 'SpaceShipFeatureManager',
	#instVars : [
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

	^ self new initializePlayersTurnWith: playerTurnAssociationGroup
]

{ #category : 'adding' }
TurnManager >> addTwoSkipsTo: aPlayer [

	| playerToApply playerIndex |
	playerIndex := self findPlayerIndex: aPlayer.
	playerToApply := playersFeature at: playerIndex.
	playerToApply := playerToApply addTwoSkips.
	playersFeature at: playerIndex put: playerToApply
]

{ #category : 'checking' }
TurnManager >> checkNoTurnsToSkip [

	| activePlayer |
	activePlayer := self playerInTurn.
	^ activePlayer skipsTurn
]

{ #category : 'initialization' }
TurnManager >> initializePlayersTurnWith: aGroup [

	playersFeature := aGroup.
	nextPlayerIndex := 0
]

{ #category : 'play interface' }
TurnManager >> nextPlayerTurnBegins [

nextPlayerIndex := (nextPlayerIndex) \\ (playersFeature size) + 1
]

{ #category : 'play interface' }
TurnManager >> playNextTurn [

	| activePlayer |
	self nextPlayerTurnBegins.
	activePlayer := self playerInTurn.
	"mientras agarre un player salteado..."
	activePlayer skipsTurn
		"ifTrue: [
			activePlayer := activePlayer turnSkipped.
			playersTurnsSkipped at: nextPlayerIndex put: activePlayer.
			aGame nextPlayerThrowsDice]"
		"ifFalse: [ aGame resetShieldsAfter2TurnsWithout ]"
		whileTrue: [
			activePlayer := activePlayer turnSkipped.
			playersFeature at: nextPlayerIndex put: activePlayer.
			self nextPlayerTurnBegins.
			activePlayer := self playerInTurn].
]

{ #category : 'accessing' }
TurnManager >> playerInTurn [

	^ playersFeature at: nextPlayerIndex
]

{ #category : 'play interface' }
TurnManager >> skipTurn [

	"turn := turn + 1."
	self nextPlayerTurnBegins.
	"activePlayer:= activePlayer forceAShieldReset."
	
	"playersTurnsSkipped at: nextPlayerIndex put: activePlayer."
]
