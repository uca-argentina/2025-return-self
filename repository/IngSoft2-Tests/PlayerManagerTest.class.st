Class {
	#name : 'PlayerManagerTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aPlayer',
		'anotherPlayer',
		'aPlayerManager'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
PlayerManagerTest >> setUp [

	super setUp.
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	anotherPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aPlayerManager := PlayerManager createWith: {
							  aPlayer.
							  anotherPlayer }
]

{ #category : 'tests' }
PlayerManagerTest >> test01WhenAManagerIsAskedForTheNameOfAShipThenItAnswersTheNameOfItsPlayer [

	self assert: (aPlayerManager nameOf: anotherPlayer) equals: 'Tomi'.
	self assert: (aPlayerManager is: aPlayer named: 'Juan')
]

{ #category : 'tests' }
PlayerManagerTest >> test02WhenAManagerIsAskedForAShipThatIsNotPlayingThenItRaisesError [

	| aStranger |
	aStranger := ShipPlayerAssociation createWith: 3 and: 'Pedro'.
	self
		should: [ aPlayerManager nameOf: aStranger ]
		raiseErrorWithMessageText: 'Player not in list'
]
