Class {
	#name : 'CardDealingTest',
	#superclass : 'GameWithCardsTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardDealingTest >> test001WhenAGameStartsThenEveryShipHasTwoCards [

	| aGame |
	aGame := self
				 gameDealing: {
						 Speed.
						 Acceleration.
						 Repeat.
						 Redo }
				 rolling: { 1 }.
	self assert: (aGame cardsFeatureOf: aPlayer) deck size equals: 2.
	self assert: ((aGame cardsFeatureOf: aPlayer) findInDeck: Speed create).
	self assert: (aGame cardsFeatureOf: anotherPlayer) deck size equals: 2.
	self assert: ((aGame cardsFeatureOf: anotherPlayer) findInDeck: Redo create)
]

{ #category : 'tests' }
CardDealingTest >> test002WhenAShipLandsOnACardGiverTileThenTheGameDealsItACard [

	| aGame |
	aTileListCreator at: 4 put: CardGiver create.
	aGame := self gameDealing: { Repeat } rolling: { 3 }.
	self play: 1 in: aGame.
	self assert: (aGame cardsFeatureOf: aPlayer) deck size equals: 3.
	self assert: (aGame cardsFeatureOf: anotherPlayer) deck size equals: 2
]
