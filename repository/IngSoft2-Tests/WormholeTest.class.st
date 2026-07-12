Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormholeTest >> test021WhenAShipStepsIntoAWormholesLowEndpointItTravelsToTheGreatEndpoint [

	| aShip aWormhole firstAnswer secondAnswer thirdAnswer |
	aShip := Ship createWith: 1.
	aWormhole := Wormhole from: 2 to: 10.

	aShip := aWormhole applyEffectOn: aShip.

	firstAnswer := aShip isIn: 1.

	aShip := aShip moveForward: 1.
	aShip := aWormhole applyEffectOn: aShip.

	secondAnswer := aShip isIn: 2.
	thirdAnswer := aShip isIn: 10.

	self assert: firstAnswer.
	self deny: secondAnswer.
	self assert: thirdAnswer
]

{ #category : 'tests' }
WormholeTest >> test022WhenAShipStepsIntoAWormholesGreatEndpointItTravelsToTheLowEndpoint [

	| aShip aWormhole firstAnswer secondAnswer thirdAnswer |
	aShip := Ship createWith: 1.
	aWormhole := Wormhole from: 2 to: 10.

	aShip := aWormhole applyEffectOn: aShip.

	firstAnswer := aShip isIn: 1.

	aShip := aShip moveForward: 9.
	aShip := aWormhole applyEffectOn: aShip.

	secondAnswer := aShip isIn: 2.
	thirdAnswer := aShip isIn: 10.

	self assert: firstAnswer.
	self assert: secondAnswer.
	self deny: thirdAnswer
]

{ #category : 'tests' }
WormholeTest >> test023TryingToCreateAWormholeWithLowestEndpointLowerThan2RaisesError [

	TestUtils
		should: [ Wormhole from: 1 to: 10 ]
		raiseWith: 'Lowest endpoint must be at least number 2.'
]

{ #category : 'tests' }
WormholeTest >> test024TryingToCreateAWormholeWithGreatEndpointLowerThanLowEndpointRaisesError [

	TestUtils
		should: [ Wormhole from: 4 to: 4 ]
		raiseWith: 'Greatest endpoint must be greater than lowest endpoint.'
]

{ #category : 'tests' }
WormholeTest >> test025DEPRECATED [
	"If greatest endpoint cant be lower or equal than lowest endpoint, then this test doesnt make sense"

	"test025TryingToCreateAWormholeWithSamePositionAndEndpointRaisesError"

	"	TestUtils
		should: [ Wormhole from: 5 to: 5 ]
		raiseWith: 'Both endpoints cant be the same.'"

	self assert: true
]
