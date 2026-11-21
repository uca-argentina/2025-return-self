Class {
	#name : 'CardDealerTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardDealerTest >> test001WhenACardDealerDealsOnlyOneKindOfCardThenEveryCardItDealsIsOfThatKind [

	| aCardDealer |
	aCardDealer := CardDealer dealing: { Speed }.
	self assert: (aCardDealer dealCard sameTypeOfCard: Speed create).
	self assert: (aCardDealer dealCard sameTypeOfCard: Speed create)
]

{ #category : 'tests' }
CardDealerTest >> test002WhenTryingToCreateACardDealerWithoutCardsThenItRaisesError [

	self
		should: [ CardDealer dealing: {  } ]
		raiseErrorWithMessageText:
		'A card dealer needs at least one kind of card to deal.'
]

{ #category : 'tests' }
CardDealerTest >> test003WhenALoadedCardDealerDealsThenItFollowsItsSequenceOverAndOverAgain [

	| aCardDealer |
	aCardDealer := LoadedCardDealer dealing: {
						   Speed.
						   Repeat }.
	self assert: (aCardDealer dealCard sameTypeOfCard: Speed create).
	self assert: (aCardDealer dealCard sameTypeOfCard: Repeat create).
	self assert: (aCardDealer dealCard sameTypeOfCard: Speed create)
]
