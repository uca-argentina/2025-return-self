Class {
	#name : 'EffectTargetTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aPlayer',
		'anotherPlayer',
		'aThirdPlayer',
		'everyPlayer'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
EffectTargetTest >> setUp [

	super setUp.
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	anotherPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aThirdPlayer := ShipPlayerAssociation createWith: 3 and: 'Pedro'.
	everyPlayer := {
					   aPlayer.
					   anotherPlayer.
					   aThirdPlayer }
]

{ #category : 'tests' }
EffectTargetTest >> test001WhenTheTargetIsTheLandingShipThenItIsTheOnlyOneAffectedAndItsOppositeAffectsEveryOtherShip [

	| aTarget |
	aTarget := LandingShip create.
	self
		assert: (aTarget shipsAffectedWhen: aPlayer landsAmong: everyPlayer)
		equals: { aPlayer }.
	self
		assert: (aTarget opposite shipsAffectedWhen: aPlayer landsAmong: everyPlayer)
		equals: {
				anotherPlayer.
				aThirdPlayer }
]

{ #category : 'tests' }
EffectTargetTest >> test002WhenTheTargetIsEveryOtherShipThenTheLandingShipIsNotAffectedAndItsOppositeAffectsOnlyTheLandingShip [

	| aTarget |
	aTarget := EveryOtherShip create.
	self
		assert: (aTarget shipsAffectedWhen: anotherPlayer landsAmong: everyPlayer)
		equals: {
				aPlayer.
				aThirdPlayer }.
	self
		assert: (aTarget opposite shipsAffectedWhen: anotherPlayer landsAmong: everyPlayer)
		equals: { anotherPlayer }
]

{ #category : 'tests' }
EffectTargetTest >> test003WhenTheTargetIsEveryShipThenItsOppositeAffectsNoShipAndTheOtherWayAround [

	| aTarget |
	aTarget := EveryShip create.
	self
		assert: (aTarget shipsAffectedWhen: aPlayer landsAmong: everyPlayer)
		equals: everyPlayer.
	self assert: (aTarget opposite shipsAffectedWhen: aPlayer landsAmong: everyPlayer) isEmpty.
	self
		assert: (aTarget opposite opposite shipsAffectedWhen: aPlayer landsAmong: everyPlayer)
		equals: everyPlayer
]
