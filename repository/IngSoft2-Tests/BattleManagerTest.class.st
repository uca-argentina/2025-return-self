Class {
	#name : 'BattleManagerTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aPlayer',
		'aBattleManager'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
BattleManagerTest >> setUp [

	| aGroupOfPlayers anotherPlayer |
	super setUp.
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	anotherPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aGroupOfPlayers := {
		                   aPlayer.
		                   anotherPlayer }.

	aBattleManager := BattleManager createWith: aGroupOfPlayers.
]

{ #category : 'tests' }
BattleManagerTest >> test01ABattleManagerCanForceAShieldResetInOneOfItsShips [
	"A little internal touching is needed, using findShipReference and updateShipReference"

	| aShieldStatus aNewShieldStatus |
	aShieldStatus := aBattleManager findShipReference: aPlayer.
	aShieldStatus := aShieldStatus loseShields: 1.
	
	"SOLO PARA TESTEO, NO DEBERIAMOS USAR updateShipReference por fuera de implementacion interna"
	aBattleManager updateShipReference: aShieldStatus.
	"SOLO PARA TESTEO, NO DEBERIAMOS USAR updateShipReference por fuera de implementacion interna"

	aBattleManager forceAShieldResetTo: aPlayer.
	aNewShieldStatus := aBattleManager findShipReference: aShieldStatus. "Better for seeing the change"

	self assert: aNewShieldStatus shields equals: 3.
	self deny: aShieldStatus shields equals: 3
]

{ #category : 'tests' }
BattleManagerTest >> test02WhenManagerEngagesTwoShipsInBattleThenItUpdatesHisArrayWithLosingShip [

	| aGroupOfPlayers anotherPlayer playerWhoLost aSequence aLoadedDie aSecondLoadedDie |
	aLoadedDie := LoadedDie rolling: 2.
	aSecondLoadedDie := LoadedDie rolling: 3.
	aSequence := SequenceOfDieForTesting withDie: {
			             aLoadedDie.
			             aSecondLoadedDie }.
	anotherPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aGroupOfPlayers := {
		                   aPlayer.
		                   anotherPlayer }.
	playerWhoLost := aBattleManager
		                 engage: aGroupOfPlayers
		                 inBattleUsing: aSequence.

	self assert: playerWhoLost shields equals: 2
]
