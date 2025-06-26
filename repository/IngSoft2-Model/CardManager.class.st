Class {
	#name : 'CardManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'permanentAppliedCards',
		'lastPlayedCard',
		'lastEffectApplied',
		'chosenPlayer',
		'activePlayer'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardManager class >> createWith: arg1 [

	| tmp1 |
	tmp1 := arg1 collect: [ :arg2 | ShipCards createWith: arg2 id ].
	^ self new initializeCardManagerWith: tmp1
]

{ #category : 'creation' }
CardManager class >> createWith: arg1 and: arg2 [

	| tmp1 |
	tmp1 := arg1 collect: [ :arg3 |
		        ShipCards createWith: arg3 id and: arg2 ].
	^ self new initializeCardManagerWith: tmp1
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

permanentAppliedCards add: aCard.
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
	permanentAppliedCards := OrderedCollection with: Speed create. "HARDCODE ELIMINAR CUANTO ANTES"
	lastPlayedCard := NoCard new.
]

{ #category : 'accessing' }
CardManager >> permanentAppliedCards [

^permanentAppliedCards .
]

{ #category : 'as yet unclassified' }
CardManager >> playLastCardCalledBy: aCaller targeting: aPlayer [
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
		                         card equalsCard: aCard ]
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
