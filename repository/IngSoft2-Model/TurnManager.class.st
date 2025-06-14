Class {
	#name : 'TurnManager',
	#superclass : 'GameFeatureManager',
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

	| playerToApply |
	playerToApply := self findShipReference: aPlayer.
	playerToApply := playerToApply addTwoSkips.
	self updateShipReference: playerToApply
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
	[ activePlayer skipsTurn ] whileTrue: [
		activePlayer := activePlayer turnSkipped.
		self updateShipReference: activePlayer.
		self nextPlayerTurnBegins.
		activePlayer := self playerInTurn ]
]

{ #category : 'accessing' }
TurnManager >> playerInTurn [

	^ playersFeature at: nextPlayerIndex
]
