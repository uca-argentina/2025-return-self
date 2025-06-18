Class {
	#name : 'SpaceShipShieldsCreationTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipShieldsCreationTest >> test01WhenTryingToCreateASpaceShipWithNegativeShieldsThenItRaisesError [
	self
		should: [ ShipShield createWith: 1 and: -10 ]
		raiseErrorWithMessageText:
		'The SpaceShip cant have negative shields.'
]
