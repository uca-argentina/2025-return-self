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
		         Speed new.
		         Acceleration new.
		         Cancellation new } asOrderedCollection.
	aShip := ShipCards createWith: 1 and: aDeck.
	activeCards := OrderedCollection new.


	aShip := aShip cardThrow: Speed create changing: activeCards.

	assertingDeck := {
		                 Acceleration new.
		                 Cancellation new } asOrderedCollection.
	assertingActive := { Speed new } asOrderedCollection.

	self assert: aShip deck equalsCollection: assertingDeck.
	self assert: activeCards equalsCollection: assertingActive
]
