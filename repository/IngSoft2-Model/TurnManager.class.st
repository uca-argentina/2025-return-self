Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'turn',
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

{ #category : 'creation' }
TurnManager class >> createWith: aGroupOfPlayers and: aNumberOfTurns [

^self new initializePlayers: aGroupOfPlayers and: aNumberOfTurns
]

{ #category : 'initialization' }
TurnManager >> initializePlayers: aGroup [

	playersTurnsSkipped := aGroup
]

{ #category : 'as yet unclassified' }
TurnManager >> playNextTurn: aGame [
	| activePlayer playerInTurnIndex |
	turn := turn + 1.
	playerInTurnIndex := self playerInTurnIndexUsing: aGame activePlayer.
	activePlayer := playersTurnsSkipped at: playerInTurnIndex.
	"mientras agarre un player salteado..."
	[activePlayer skipsTurn] whileTrue: [
		turn := turn + 1.
		activePlayer := activePlayer turnSkipped.
		].
	playersTurnsSkipped at: playerInTurnIndex put: activePlayer.
	activePlayer:= activePlayer resetShieldsAfter2TurnsWithout.

]

{ #category : 'as yet unclassified' }
TurnManager >> playerInTurnIndexUsing: aPlayer [

^ playersTurnsSkipped findFirst: [ :each | each equals: aPlayer ]
]

{ #category : 'play interface' }
TurnManager >> skipTurn [
	| activePlayer |
	turn := turn + 1.
	activePlayer := playersTurnsSkipped at: self playerInTurnIndex.
	activePlayer:= activePlayer forceAShieldReset.
	
	playersTurnsSkipped at: self playerInTurnIndex put: activePlayer.
	^ activePlayer
]

{ #category : 'as yet unclassified' }
TurnManager >> turnsThatPassed [
^turn
]

{ #category : 'updating' }
TurnManager >> updateWith: aGroupOfPlayers [

^self class createWith: aGroupOfPlayers and: turn
]
