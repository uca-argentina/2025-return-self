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

	| aDeck aShip activeCards assertingData assertingDeck assertingActive |
	aDeck := OrderedCollection withAll: {
			         Speed create.
			         Acceleration create.
			         Cancellation new }.
	aShip := ShipCards createWith: 1 and: aDeck.
	activeCards := OrderedCollection new.


	aShip := aShip cardThrow: Speed create changing: activeCards.
	
	assertingDeck := { Acceleration create . Cancellation new } asArray.
	assertingActive := { Speed create } asArray.

	aShip deck asArray withIndexDo: [ :card :index |
		self assert: (card sameTypeOfCard: (assertingDeck at: index)) ].
	activeCards asArray withIndexDo: [ :card :index |
		self assert: (card sameTypeOfCard: (assertingActive at: index)) ]
	"self assert: (aShip deck asArray at: 1) equals: assertingData."
	"self assert: activeCards equals: { Speed create } asOrderedCollection"
]
