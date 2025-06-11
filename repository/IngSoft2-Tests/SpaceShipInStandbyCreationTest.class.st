Class {
	#name : 'SpaceShipInStandbyCreationTest',
	#superclass : 'InstanceCreationTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipInStandbyCreationTest >> testWhenTryingToCreateASpaceShipWithNegativeTurnsToSkipThenItRaisesError [
	self
		should: [ ShipInStandBy createWith: 1 and: -10 ]
		raiseErrorWithMessageText:
		'The SpaceShip cant skip negative turns.'
]
