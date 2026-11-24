Class {
	#name : 'ShipInStandbyTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipInStandbyTest >> test001WhenAShipInStandBySkipsATurnThenTheNumberOfTurnsItHasDecreaseOne [

	| aShipInStandBy aModifiedShipInStandBy |
	aShipInStandBy := ShipInStandBy createWith: 1 and: 2.

	aModifiedShipInStandBy := aShipInStandBy skipATurn.

	self assert: aModifiedShipInStandBy turnsToSkip equals: 1.
	self deny: aShipInStandBy turnsToSkip equals: 1 "Here you can be sure that original object is not affected"
]

{ #category : 'tests' }
ShipInStandbyTest >> test002WhenAShipInStandByHasNotTurnsToSkipThenSkippingRaisesError [

	| aShipInStandBy |
	aShipInStandBy := ShipInStandBy createWith: 1 and: 0.

	self
		should: [ aShipInStandBy skipATurn ]
		raiseErrorWithMessageText: 'The SpaceShip cant skip negative turns.'
]

{ #category : 'tests' }
ShipInStandbyTest >> test003AShipInStandByCanAnswerIfItHasTurnsToSkip [

	| aShipInStandBy aModifiedShipInStandBy |
	aShipInStandBy := ShipInStandBy createWith: 1 and: 1.

	aModifiedShipInStandBy := aShipInStandBy skipATurn.

	self assert: aShipInStandBy hasTurnsToSkip.
	self deny: aModifiedShipInStandBy hasTurnsToSkip "Here you can be sure that original object is not affected"
]

{ #category : 'tests' }
ShipInStandbyTest >> test004WhenAShipIsAddedTurnsToSkipThenItReturnsANewShipInStandByWith2TurnsToSkip [

	| aShipInStandBy aModifiedShipInStandBy |
	aShipInStandBy := ShipInStandBy createWith: 1 and: 2.

	aModifiedShipInStandBy := aShipInStandBy addSkips: 2.

	self assert: aModifiedShipInStandBy turnsToSkip equals: 4.
	self deny: aShipInStandBy turnsToSkip equals: 4 "Here you can be sure that original object is not affected"
]

{ #category : 'tests' }
ShipInStandbyTest >> test005WhenTryingToCreateASpaceShipWithNegativeTurnsToSkipThenItRaisesError [

	self
		should: [ ShipInStandBy createWith: 1 and: -10 ]
		raiseErrorWithMessageText:
		'The SpaceShip cant skip negative turns.'
]
