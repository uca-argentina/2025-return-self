Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormholeTest >> test021WhenAShipStepsIntoAWormholeItTravelsToTheOppositeSideWhenEndpointIsGreaterThanPosition [

	| aShip aWormhole firstAnswer secondAnswer thirdAnswer |
	aShip := Ship createWith: 1.
	aWormhole := Wormhole createWith: 10 in: 2.

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
WormholeTest >> test022WhenAShipStepsIntoAWormholeItTravelsToTheOppositeSideWhenEndpointIsLowerThanPosition [

	| aShip aWormhole firstAnswer secondAnswer thirdAnswer |
	aShip := Ship createWith: 1.
	aWormhole := Wormhole createWith: 2 in: 10.

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
