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
TurnManager >> nextTurnPlayer [
	| activePlayer |
	turn := turn + 1.
	activePlayer := playersTurnsSkipped at: self playerInTurnIndex.
	
	"VER"
	[activePlayer skipATurn] whileTrue: [
		playersTurnsSkipped at: self playerInTurnIndex put:(activePlayer turnSkipped ).
		turn := turn + 1.
		activePlayer := playersTurnsSkipped at: self playerInTurnIndex.
		].
	
	activePlayer:= activePlayer resetShieldsAfter2TurnsWithout.
	playersTurnsSkipped at: self playerInTurnIndex put: activePlayer.
	^ activePlayer
]

{ #category : 'as yet unclassified' }
TurnManager >> nextTurnPlayerBanana: aGame [
	| activePlayer |
	turn := turn + 1.
	aGame nextPlayerTurnBegins.
	activePlayer := aGame activePlayer.
	
	"VER, mientras agarre un player salteado..."
	[activePlayer skipATurn] whileTrue: [
		aGame updateWithModified: activePlayer.
		turn := turn + 1.
		activePlayer := aGame findPlayerAt: self playerInTurnIndex.
		].
	
	activePlayer:= activePlayer resetShieldsAfter2TurnsWithout.
	aGame updateWithModified: activePlayer.
	^ activePlayer
]

{ #category : 'play interface' }
TurnManager >> playerInTurnIndex [

	^ turn - 1 \\ playersTurnsSkipped size + 1 "The players whose turn is up"
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
