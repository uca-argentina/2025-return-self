Class {
	#name : 'ShipCardTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipCardTest >> test01WhenACardIsAddedToTheHandOfAShipThenItAnswersANewHandWithThatCard [

	| aShipCards anUpdatedShipCards |
	aShipCards := ShipCards createWith: 1 and: { Speed create }.
	anUpdatedShipCards := aShipCards addToDeck: Repeat create.
	self assert: (anUpdatedShipCards findInDeck: Repeat create).
	self deny: (aShipCards findInDeck: Repeat create)
]

{ #category : 'tests' }
ShipCardTest >> test02WhenACardIsDiscardedFromTheHandOfAShipThenItAnswersANewHandWithoutThatCard [

	| aShipCards anUpdatedShipCards |
	aShipCards := ShipCards createWith: 1 and: {
						  Speed create.
						  Repeat create }.
	anUpdatedShipCards := aShipCards removeFromDeck: Speed create.
	self deny: (anUpdatedShipCards findInDeck: Speed create).
	self assert: (anUpdatedShipCards findInDeck: Repeat create).
	self assert: (aShipCards findInDeck: Speed create)
]

{ #category : 'tests' }
ShipCardTest >> test03WhenTryingToDiscardACardThatIsNotInTheHandOfAShipThenItRaisesError [

	| aShipCards |
	aShipCards := ShipCards createWith: 1 and: { Speed create }.
	self
		should: [ aShipCards removeFromDeck: Repeat create ]
		raiseErrorWithMessageText: 'Player does not have this card on deck.'
]
