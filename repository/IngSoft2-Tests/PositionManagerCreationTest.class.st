Class {
	#name : 'PositionManagerCreationTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PositionManagerCreationTest >> test01WhenTryingToCreateAPositionManagerWithNegativeLapsThenItRaisesError [

	| aGroupOfPlayers aTestBoard |
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: {  }.
	aGroupOfPlayers := {
		                   (ShipPlayerAssociation
			                    createWith: 1
			                    and: 'Pedro').
		                   (ShipPlayerAssociation createWith: 2 and: 'Juan') }.
	self
		should: [
			PositionManager createWith: aGroupOfPlayers and: aTestBoard totalTiles and: -10]
		raiseErrorWithMessageText:
		'The amount of laps cannot be lower than 1.'
]
