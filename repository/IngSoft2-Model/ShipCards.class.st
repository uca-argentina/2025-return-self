Class {
	#name : 'ShipCards',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'deck',
		'preparedCard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'error handling' }
ShipCards class >> cardsShouldBeAtLeastTwo: aCollectionOfCards [

	"aCollectionOfCards size < 2 ifTrue: [ Error signal:'Card collection must be initialized with at least 2.' ]" "DE MOMENTO NO TIENE UTILIDAD, PORQUE ESTA CLASE TIENE QUE SER INMUTABLE"
]

{ #category : 'creation' }
ShipCards class >> createWith: anId [

	| cardClasses aCardDeck |
	self idShouldBeGreaterThanZero: anId.
	cardClasses := {
		               Acceleration.
		               Cancellation.
		               Mercenary.
		               Redo.
		               Repeat.
		               Speed }.
	aCardDeck := OrderedCollection new.
	1 to: 2 do: [ :x |
		| aRandomIndex |
		aRandomIndex := (1 to: cardClasses size) atRandom.
		aCardDeck add: (cardClasses at: aRandomIndex) new ].

	^ self new initializeWith: anId and: aCardDeck and: NoCard new
]

{ #category : 'creation' }
ShipCards class >> createWith: anId and: aCardDeck [

	self idShouldBeGreaterThanZero: anId.

	^ self new initializeWith: anId and: aCardDeck and: NoCard new
]

{ #category : 'creation' }
ShipCards class >> createWith: anId and: aCardDeck and: aPreparedCard [

	self idShouldBeGreaterThanZero: anId.
	self preparedCardCantBeANoCard: aPreparedCard.

	^ self new initializeWith: anId and: aCardDeck and: aPreparedCard
]

{ #category : 'as yet unclassified' }
ShipCards class >> preparedCardCantBeANoCard: aPreparedCard [

	aPreparedCard isNoCard ifTrue: [
		Error signal: 'This is not a card to be played.' ]
]

{ #category : 'adding' }
ShipCards >> addToDeck: aCard [

	| aNewDeck |
	aNewDeck := OrderedCollection withAll: deck.
	aNewDeck add: aCard.
	^ self class createWith: id and: aNewDeck
]

{ #category : 'copying' }
ShipCards >> copyShip [

^ self class createWith: id and: deck
]

{ #category : 'accessing' }
ShipCards >> deck [

	^ deck
]

{ #category : 'adding' }
ShipCards >> findInDeck: card [

	^ deck anySatisfy: [ :x | x sameTypeOfCard: card ]
]

{ #category : 'play interface' }
ShipCards >> for: aCard ifAnySetupWith: context [

	| cardForSetup cardSetted deckPlaceIndex aNewDeck |
	cardForSetup := deck
		                detect: [ :card | card sameTypeOfCard: aCard ]
		                ifNone: [
		                Error signal:
			                'Player does not have this card on deck.' ].
	cardSetted := cardForSetup setupWith: context.
	deckPlaceIndex := deck findFirst: [ :card |
		                  card sameTypeOfCard: cardSetted ].

	aNewDeck := OrderedCollection withAll: deck.
	aNewDeck at: deckPlaceIndex put: cardSetted.
	
	^ self class createWith: id and: aNewDeck and: preparedCard
]

{ #category : 'initialization' }
ShipCards >> initializeWith: anId and: aCardDeck and: aPreparedCard [

	id := anId.
	deck := aCardDeck.
	preparedCard := aPreparedCard
]

{ #category : 'adding' }
ShipCards >> popFromDeck: aCard [

	| cardToRemove |
	cardToRemove := deck detect: [ :card | card sameTypeOfCard: aCard ].
	deck remove: cardToRemove.
	^ cardToRemove
]

{ #category : 'as yet unclassified' }
ShipCards >> throwInstantCardUsing: cardManager [

	| aNewDeck cardToRemove |
	aNewDeck := deck collect: [ :card | card ].
	
	cardToRemove := aNewDeck detect: [ :card | card sameTypeOfCard: preparedCard ].
	cardToRemove isRedo ifFalse: [ cardManager storeLastCardPlayed: cardToRemove ].
	cardToRemove applyBonusUsing: cardManager.
	
	aNewDeck remove: cardToRemove.

	^ self class createWith: id and: aNewDeck
]

{ #category : 'as yet unclassified' }
ShipCards >> throwPermanentCardUsing: cardManager [

	| aNewDeck cardToRemove |
	aNewDeck := deck collect: [ :card | card ].
	cardToRemove := aNewDeck detect: [ :card |
		                card equalsACard: preparedCard ].
	cardManager addToPermanentCards: cardToRemove. "Revisar"

	cardManager storeLastCardPlayed: cardToRemove class. "Ver si tengo que hacer una cosita mas o no"

	aNewDeck remove: cardToRemove.

	^ self class createWith: id and: aNewDeck
]

{ #category : 'as yet unclassified' }
ShipCards >> throwPreparedCardUsing: cardManager [

	preparedCard isPermanentCard ifTrue: [ ^ self throwPermanentCardUsing: cardManager ].
	
	preparedCard isInstantCard ifTrue: [ ^ self throwInstantCardUsing: cardManager ].
]
