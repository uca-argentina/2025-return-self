Class {
	#name : 'TurnManagerTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aTurnManager',
		'aPlayer',
		'anotherPlayer'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
TurnManagerTest >> setUp [

	| aGroupOfPlayers |
	super setUp.
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	anotherPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aGroupOfPlayers := {
		aPlayer.
		anotherPlayer }.
	aTurnManager := TurnManager createWith: aGroupOfPlayers
]

{ #category : 'tests' }
TurnManagerTest >> test01WhenManagerAddsSkipsToAShipThenItUpdatesItsArrayWithTheNewStatus [

	| originalTurnStatus newTurnStatus |
	originalTurnStatus := aTurnManager findShipReference: aPlayer.
	aTurnManager addTwoSkipsTo: aPlayer.
	newTurnStatus := aTurnManager findShipReference: aPlayer.
	self assert: originalTurnStatus turnsToSkip equals: 0.
	self assert: newTurnStatus turnsToSkip equals: 2
]

{ #category : 'tests' }
TurnManagerTest >> test02WhenATurnEndsThenManagerChangesThePlayerInTurn [

	| originalTurnPlayer newTurnPlayer |
	originalTurnPlayer := aTurnManager playerInTurn.
	aTurnManager endTurn.
	newTurnPlayer := aTurnManager playerInTurn.
	self assert: originalTurnPlayer id equals: 1.
	self assert: newTurnPlayer id equals: 2
]

{ #category : 'tests' }
TurnManagerTest >> test03WhenTheTurnOfTheLastShipEndsThenItIsTheTurnOfTheFirstShipAgain [

	aTurnManager endTurn.
	aTurnManager endTurn.
	self assert: aTurnManager playerInTurn id equals: 1
]

{ #category : 'tests' }
TurnManagerTest >> test04WhenManagerAddsSkipsToBothShipsAndATurnBeginsThenItDiscountsTheirTurnsUntilAShipCanPlay [

	aTurnManager addTwoSkipsTo: aPlayer.
	aTurnManager addTwoSkipsTo: anotherPlayer.
	aTurnManager beginTurn.
	self assert: aTurnManager playerInTurn id equals: 1.
	self assert: (aTurnManager findShipReference: aPlayer) turnsToSkip equals: 0.
	self assert: (aTurnManager findShipReference: anotherPlayer) turnsToSkip equals: 0
]

{ #category : 'tests' }
TurnManagerTest >> test05WhenATurnWasPlayedThenItIsTheTurnOfTheNextShip [

	aTurnManager endTurn.
	self assert: (aTurnManager isTurnOf: anotherPlayer).
	self deny: (aTurnManager isTurnOf: aPlayer)
]

{ #category : 'tests' }
TurnManagerTest >> test06WhenTheNextShipHasToLoseItsTurnThenItIsNotItsTurnAndItsLostTurnsStayUntouched [

	aTurnManager endTurn.
	aTurnManager addTwoSkipsTo: anotherPlayer.
	self assert: (aTurnManager isTurnOf: aPlayer).
	self assert: (aTurnManager findShipReference: anotherPlayer) turnsToSkip equals: 2
]
