Class {
	#name : 'ShipCardTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipCardTest >> test01ShipCanThrowACard [


	| aDeck aShip activeCards assertingDeck assertingActive |
	aDeck := {
		         Speed create.
		         Acceleration create.
		         Cancellation new } asOrderedCollection.
	aShip := ShipCards createWith: 1 and: aDeck.
	activeCards := OrderedCollection new.


	aShip := aShip cardThrow: Speed create changing: activeCards.

	assertingDeck := {
		                 Acceleration create.
		                 Cancellation new } asOrderedCollection.
	assertingActive := { Speed create } asOrderedCollection.

	self assert: aShip deck equalsCollection: assertingDeck.
	self assert: activeCards equalsCollection: assertingActive.

]
