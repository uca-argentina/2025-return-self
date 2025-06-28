Class {
	#name : 'CardManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'permanentAppliedCards',
		'lastPlayedCard',
		'lastEffectApplied',
		'incrementalTag'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardManager class >> createWith: aGroupOfPlayers [

	| cardPlayerAsociation |
	cardPlayerAsociation := aGroupOfPlayers collect: [ :ship |
		                        ShipCards createWith: ship id ].
	^ self new
		  initializeCardManagerWith: cardPlayerAsociation
		  and: OrderedCollection new
]

{ #category : 'creation' }
CardManager class >> createWith: aGroupOfPlayers and: aCardDeck [

	| cardPlayerAsociation |
	cardPlayerAsociation := aGroupOfPlayers collect: [ :ship |
		                        ShipCards createWith: ship id and: aCardDeck ].
	^ self new
		  initializeCardManagerWith: cardPlayerAsociation
		  and: OrderedCollection new
]

{ #category : 'creation' }
CardManager class >> createWith: aGroupOfPlayers and: aCardDeck having: permanentAppliedCards [

	| cardPlayerAsociation |
	cardPlayerAsociation := aGroupOfPlayers collect: [ :ship |
		                        ShipCards createWith: ship id and: aCardDeck ].
	^ self new
		  initializeCardManagerWith: cardPlayerAsociation
		  and: permanentAppliedCards
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
	aCard isMercenary ifTrue: [ self checkNoSameSlave: aCard ].
	taggedCard := aCard tagPermanentCard: incrementalTag.
	permanentAppliedCards add: taggedCard.
	incrementalTag := incrementalTag + 1
]

{ #category : 'as yet unclassified' }
CardManager >> checkIfBonusToApplyTo: aPlayer using: setOfDie [

	| everyCardToApplyBonus aTotalThrow |
	aTotalThrow := setOfDie throw.
	everyCardToApplyBonus := permanentAppliedCards select: [ :card |
		                         card affects: aPlayer ].
	^ everyCardToApplyBonus inject: aTotalThrow into: [ :acum :card | card applyBonusUsing: aTotalThrow ]
]

{ #category : 'as yet unclassified' }
CardManager >> checkIfMercenariesFor: aMaster using: battleManager [

	| everyCardToApplyBonus aTeam |
	everyCardToApplyBonus := permanentAppliedCards select: [ :card |
		                         card requestedBy: aMaster ].
	aTeam := (everyCardToApplyBonus collect: [ :card |
		          card applyBonusUsing: battleManager ]) asOrderedCollection.
	aTeam add: aMaster.
	^ aTeam
]

{ #category : 'as yet unclassified' }
CardManager >> checkNoSameSlave: aMercenaryPreparedCard [

	| allMercenaryCards |
	allMercenaryCards := permanentAppliedCards select: [ :card |
		                     card isMercenary ].
	allMercenaryCards
		detect: [ :card | card hasSameSlave: aMercenaryPreparedCard ]
		ifFound: [ Error signal: 'Cant have the same mercenary as other.' ]
		ifNone: [  ]
]

{ #category : 'as yet unclassified' }
CardManager >> evaluateIfCardIsPresent: player forCard: card [

	| playerReference |
	playerReference := self findShipReference: player.
	(playerReference findInDeck: card) ifFalse: [
		Error signal: 'Player does not have such card' ]
]

{ #category : 'initialization' }
CardManager >> initializeCardManagerWith: aGroupOfPlayers and: permanentCards [

	playersFeature := aGroupOfPlayers.
	permanentAppliedCards := permanentCards.
	lastPlayedCard := NoCard new.
	incrementalTag := 1
	
]

{ #category : 'accessing' }
CardManager >> lastEffectApplied [

	^ lastEffectApplied
]

{ #category : 'accessing' }
CardManager >> lastPlayedCard [

	^ lastPlayedCard new
]

{ #category : 'accessing' }
CardManager >> permanentAppliedCards [

	| copyOfAppliedCards |
	copyOfAppliedCards := permanentAppliedCards collect: [ :card | card ].
	^ copyOfAppliedCards
]

{ #category : 'play interface' }
CardManager >> player: aPlayer preparesIfAny: aCard setupWith: context [

	| shipCards |
	shipCards := self findShipReference: aPlayer.
	shipCards := shipCards for: aCard ifAnySetupWith: context.
	self updateShipReference: shipCards.

	shipCards := shipCards throwPreparedCardUsing: self.
	self updateShipReference: shipCards
]

{ #category : 'removing' }
CardManager >> removeActiveCardWith: cardId [

	| cardToCancel |
	cardToCancel := permanentAppliedCards
		                detect: [ :card | card withTag: cardId ]
		                ifNone: [
		                Error signal:
			                'There was no permanent card with that id.' ].
	permanentAppliedCards remove: cardToCancel
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
CardManager >> trimContextConsultingManual: aContext [
	"Similates a database"

	"Cards with two parameters, card isBlaBla, card isBluBlu... "

	lastPlayedCard new isMercenary ifTrue: [
		^ {
			  (aContext at: 2).
			  (aContext at: 1) } ].

	"Cards with one parameter, card isBla, card isBlu..."
	^ aContext at: 1 "Up to this day, al those classes which use one or none arguments, need chosenShip more
than the caller"
]
