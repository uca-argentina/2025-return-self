Class {
	#name : 'ShipShieldTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipShieldTest >> test01ShipCanLoseShieldsIfItHasAtLeastOne [

	| aShipShield aModifidiedShipShield |
	aShipShield := ShipShield createWith: 1 and: 1.

	aModifidiedShipShield := aShipShield loseShields: 1.

	self assert: aModifidiedShipShield shields equals: 0.
	self deny: aShipShield shields equals: 0 "Here you can be sure that original object is not affected"
]

{ #category : 'tests' }
ShipShieldTest >> test02ShipCantLoseShieldsIfItHasNone [

	| aShipShield anotherShipShield |
	aShipShield := ShipShield createWith: 1 and: 0.
	anotherShipShield := aShipShield loseShields: 1.
	self assert: (anotherShipShield shields) equals: 0.

]

{ #category : 'tests' }
ShipShieldTest >> test03WhenAShipIsForcedAShieldResetThenItReturnsANewFullShieldShip [

	| aShipShield aModifiedShipShield |
	aShipShield := ShipShield createWith: 1 and: 0.

	aModifiedShipShield := aShipShield forceAShieldReset.

	self assert: aModifiedShipShield shields equals: 3.
	self deny: aShipShield shields equals: 3 "Here you can be sure that original object is not affected"
]

{ #category : 'tests' }
ShipShieldTest >> test04AShipCanInformIfItNeedsRecovery [

	| aShipShield aModifiedShipShield |
	aShipShield := ShipShield createWith: 1 and: 0.

	aModifiedShipShield := aShipShield forceAShieldReset.

	self assert: aShipShield needsRecovery. "Here you can be sure that original object is not affected"
	self deny: aModifiedShipShield needsRecovery
]
