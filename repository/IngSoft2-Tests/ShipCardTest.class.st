Class {
	#name : 'ShipCardTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipCardTest >> test01ShipCanThrowACard [
"una OrderedCollection de cartas, las que quieran, ese es el deck, crean un ShipCards con
ese deck, crean una Ordered"
| aDeck aShip activeCards newDeck assertingData |
aDeck := OrderedCollection withAll: { Speed create. Acceleration create }.
aShip := ShipCards createWith: 1 and: aDeck.
activeCards := OrderedCollection new.

aShip := aShip cardThrow: Speed create changing: activeCards.
assertingData := aShip deck = { Acceleration create } asOrderedCollection.
self assert: assertingData equals: true.
self assert: activeCards equals: { Speed create } asOrderedCollection
]
