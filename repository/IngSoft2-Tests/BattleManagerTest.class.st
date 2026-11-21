Class {
	#name : 'BattleManagerTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aPlayer',
		'anotherPlayer',
		'aBattleManager'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
BattleManagerTest >> setUp [

	super setUp.
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	anotherPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aBattleManager := BattleManager createWith: {
							  aPlayer.
							  anotherPlayer }
]

{ #category : 'tests' }
BattleManagerTest >> test001ABattleManagerCanForceAShieldResetInOneOfItsShips [

	aBattleManager playerLoseShield: aPlayer.
	self assert: (aBattleManager findShipReference: aPlayer) shields equals: 2.
	aBattleManager forceAShieldResetTo: aPlayer.
	self assert: (aBattleManager findShipReference: aPlayer) shields equals: 3
]

{ #category : 'tests' }
BattleManagerTest >> test002WhenATeamThrowsLessThanItsRivalThenItDoesNotDefeatIt [

	| aSequence |
	aSequence := SequenceOfDieForTesting withDie: {
						 (LoadedDie rolling: 2).
						 (LoadedDie rolling: 3) }.
	self deny: (aBattleManager
			 team: { aPlayer }
			 defeats: { anotherPlayer }
			 using: aSequence)
]

{ #category : 'tests' }
BattleManagerTest >> test003WhenATeamHasSeveralShipsThenItsBestThrowIsTheOneThatCounts [

	| aSequence aThirdPlayer |
	aThirdPlayer := ShipPlayerAssociation createWith: 3 and: 'Pedro'.
	aSequence := SequenceOfDieForTesting withDie: {
						 (LoadedDie rolling: 1).
						 (LoadedDie rolling: 6).
						 (LoadedDie rolling: 5) }.
	self assert: (aBattleManager
			 team: {
					 aPlayer.
					 anotherPlayer }
			 defeats: { aThirdPlayer }
			 using: aSequence)
]

{ #category : 'tests' }
BattleManagerTest >> test004WhenBothTeamsTieThenTheyThrowAgain [

	| aSequence |
	aSequence := SequenceOfDieForTesting withDie: {
						 (LoadedDie rolling: 4).
						 (LoadedDie rolling: 4).
						 (LoadedDie rolling: 5).
						 (LoadedDie rolling: 2) }.
	self assert: (aBattleManager
			 team: { aPlayer }
			 defeats: { anotherPlayer }
			 using: aSequence)
]
