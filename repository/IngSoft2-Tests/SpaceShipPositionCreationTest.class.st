Class {
	#name : 'SpaceShipPositionCreationTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipPositionCreationTest >> test01WhenTryingToCreateASpaceShipWithNegativePositionThenItThrowsError [

	self
		should: [ ShipPosition createWith: 1 and: -10 and: 0 ]
		raiseErrorWithMessageText:
		'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
SpaceShipPositionCreationTest >> test02WhenTryingToCreateASpaceShipWithNegativeLapThenItThrowsError [

	self
		should: [ ShipPosition createWith: 1 and: 10 and: -2 ]
		raiseErrorWithMessageText:
		'Player lap cannot be negative.'
]
