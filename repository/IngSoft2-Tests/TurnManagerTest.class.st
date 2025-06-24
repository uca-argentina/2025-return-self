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

	aTurnManager := TurnManager createWith: aGroupOfPlayers.
	aTurnManager nextPlayerTurnBegins
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
TurnManagerTest >> test02WhenNextTurnBeginsThenManagerChangesNextPlayerIndex [

	| originalTurnPlayer newTurnPlayer |
	originalTurnPlayer := aTurnManager playerInTurn.

	aTurnManager nextPlayerTurnBegins.
	newTurnPlayer := aTurnManager playerInTurn.

	self assert: originalTurnPlayer id equals: 1.
	self assert: newTurnPlayer id equals: 2
]

{ #category : 'tests' }
TurnManagerTest >> test03ATurnManagerNotStartedWithNextPlayerTurnBeginsCantReturnAPlayerInTurn [

	| anotherTurnManager |
	anotherTurnManager := TurnManager createWith: {
			                      aPlayer.
			                      anotherPlayer }.
	self
		should: [ anotherTurnManager playerInTurn ]
		raiseErrorWithMessageText:
		'The game did not begin.'
]

{ #category : 'tests' }
TurnManagerTest >> test04WhenManagerAddsSkipsToBothShipsAndPlaysNextTurnThenItDiscountsTurnsAndChangesNextPlayerIndex [

	| originalTurnStatus newTurnStatus |
	aTurnManager addTwoSkipsTo: aPlayer.
	aTurnManager addTwoSkipsTo: anotherPlayer.
	originalTurnStatus := aTurnManager playerInTurn.
	
	aTurnManager playNextTurn.
	newTurnStatus := aTurnManager playerInTurn.

	self assert: originalTurnStatus turnsToSkip equals: 2.
	self assert: newTurnStatus turnsToSkip equals: 0.
]
