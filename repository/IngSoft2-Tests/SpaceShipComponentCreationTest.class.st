Class {
	#name : 'SpaceShipComponentCreationTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipComponentCreationTest >> test01WhenTryingToCreateASpaceShipWithNegativeIDItRaisesError [

	self
		should: [ ShipPlayerAssociation createWith: 0 and: 'Pedro' ]
		raiseErrorWithMessageText:
		'The SpaceShip ID should be greater than zero.'.
	self
		should: [ ShipInStandBy createWith: 0 and: 0 ]
		raiseErrorWithMessageText:
		'The SpaceShip ID should be greater than zero.'.
	self
		should: [ ShipPosition createWith: 0 and: 1 ]
		raiseErrorWithMessageText:
		'The SpaceShip ID should be greater than zero.'.
	self
		should: [ ShipShield createWith: 0 and: 3 ]
		raiseErrorWithMessageText:
		'The SpaceShip ID should be greater than zero.'.
	self
		should: [ ShipCards createWith: 0 and: {  } ]
		raiseErrorWithMessageText:
		'The SpaceShip ID should be greater than zero.'
]
