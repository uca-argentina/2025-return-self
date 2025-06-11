Class {
	#name : 'SpaceShipShieldsCreationTest',
	#superclass : 'InstanceCreationTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipShieldsCreationTest >> testWhenTryingToCreateASpaceShipWithNegativeShieldsThenItRaisesError [
	self
		should: [ ShipShield createWith: 1 and: -10 ]
		raiseErrorWithMessageText:
		'The SpaceShip cant have negative shields.'
]
