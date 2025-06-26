Class {
	#name : 'CardManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'permanentAppliedCards',
		'lastPlayedCard',
		'lastEffectApplied',
		'activePlayer',
		'chosenPlayer',
		'incrementalTag'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardManager class >> createWith: aGroupOfPlayers [

	| cardPlayerAsociation |
	cardPlayerAsociation := aGroupOfPlayers collect: [ :ship | ShipCards createWith: ship id ].
	^ self new initializeCardManagerWith: cardPlayerAsociation
]

{ #category : 'creation' }
CardManager class >> createWith: aGroupOfPlayers and: aCardDeck [

	| cardPlayerAsociation |
	cardPlayerAsociation := aGroupOfPlayers collect: [ :ship |
		                        ShipCards createWith: ship id and: aCardDeck ].
	^ self new initializeCardManagerWith: cardPlayerAsociation
]

{ #category : 'adding-removing' }
CardManager >> add: card to: player [

	| playerReference |
	playerReference := self findShipReference: player.
	playerReference := playerReference addToDeck: card.
	self updateShipReference: playerReference
]

{ #category : 'adding-removing' }
CardManager >> addToPermanentCards: aCard [

	| taggedCard |
	taggedCard := aCard tagPermanentCard: incrementalTag.
	permanentAppliedCards add: aCard.
	incrementalTag := incrementalTag + 1
]

{ #category : 'as yet unclassified' }
CardManager >> evaluateIfCardIsPresent: player forCard: card [

	| playerReference |
	playerReference := self findShipReference: player.
	(playerReference findInDeck: card) ifFalse: [
		Error signal: 'Player does not have such card' ]
]

{ #category : 'initialization' }
CardManager >> initializeCardManagerWith: aGroupOfPlayers [

	playersFeature := aGroupOfPlayers.
	permanentAppliedCards := OrderedCollection new.
	lastPlayedCard := NoCard new.
	incrementalTag := 1
	
]

{ #category : 'accessing' }
CardManager >> permanentAppliedCards [

^permanentAppliedCards .
]

{ #category : 'as yet unclassified' }
CardManager >> playLastCardCalledBy: aCaller targeting: aPlayer [
]

{ #category : 'play interface' }
CardManager >> player: aPlayer preparesIfAny: aCard setupWith: context [

	| shipCards |
	shipCards := self findShipReference: aPlayer.
	shipCards := shipCards for: aCard ifAnySetupWith: context.
	self updateShipReference: shipCards.
	
	shipCards := shipCards throwPreparedCardUsing: self
]

{ #category : 'as yet unclassified' }
CardManager >> replicateEffect: anEffect from: player targeting: anotherPlayer using: aGame [

"	| playedCard |
	self evaluateIfCardIsPresent: player forCard: Repeat new.
	playedCard := self useCard: Repeat new from: player.
	playedCard replicateEffect: anEffect targeting: anotherPlayer using: aGame."
	
]

{ #category : 'adding-removing' }
CardManager >> searchAndCancel: aCard [

	permanentAppliedCards := permanentAppliedCards reject: [ :card |
		                         card sameTypeOfCard: aCard ]
]

{ #category : 'as yet unclassified' }
CardManager >> store: aPlayer and: aChosenPlayer [

	| aShipCard chosenShipCard |
	aShipCard := self findShipReference: aPlayer.
	chosenShipCard := self findShipReference: aChosenPlayer.
	activePlayer := aShipCard copyShip.
	chosenPlayer := chosenShipCard copyShip
]

{ #category : 'as yet unclassified' }
CardManager >> storeLastCardPlayed: playedCard [

	lastPlayedCard := playedCard
]

{ #category : 'as yet unclassified' }
CardManager >> storeLastEffectApplied: anEffect [

	lastEffectApplied := anEffect 
]

{ #category : 'as yet unclassified' }
CardManager >> useCard: card from: player [

	| playerReference |
	playerReference := self findShipReference: player.
	"^ playerReference popFromDeck: card "
]
