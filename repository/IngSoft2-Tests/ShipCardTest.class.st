Class {
	#name : 'ShipCardTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipCardTest >> test01ShipCanThrowACard [
"Chequear acoplamiento, no se puede testear ShipCards sin cardManager y eso está mal"

	| aDeck aShip aManager assertingDeck assertingActive aRandomShip |
	aDeck := {
		         Speed create.
		         Acceleration create.
		         Cancellation new } asOrderedCollection.
	aShip := ShipCards createWith: 1 and: aDeck.
	aRandomShip := ShipCards createWith: 2.
	aManager := CardManager createWith: { aShip. aRandomShip } and: aDeck.


	"aShip := aShip cardThrow: Speed create changing: activeCards."
	aShip := aShip for: Speed new ifAnySetupWith: aShip.
	aShip := aShip throwPreparedCardUsing: aManager.

	assertingDeck := {
		                 Acceleration create.
		                 Cancellation new } asOrderedCollection.
	assertingActive := { Speed create } asOrderedCollection.

	self assert: aShip deck equalsCollection: assertingDeck.
	self assert: aManager permanentAppliedCards equalsCollection: assertingActive.

]
