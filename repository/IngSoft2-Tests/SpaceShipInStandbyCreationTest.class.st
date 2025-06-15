Class {
	#name : 'SpaceShipInStandbyCreationTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipInStandbyCreationTest >> test01WhenTryingToCreateASpaceShipWithNegativeTurnsToSkipThenItRaisesError [
	self
		should: [ ShipInStandBy createWith: 1 and: -10 ]
		raiseErrorWithMessageText:
		'The SpaceShip cant skip negative turns.'
]
