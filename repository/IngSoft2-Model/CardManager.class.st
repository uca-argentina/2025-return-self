Class {
	#name : 'CardManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'permanentAppliedCards',
		'lastPlayedCard'
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

{ #category : 'adding' }
CardManager >> add: arg1 to: arg2 [

	| tmp1 |
	tmp1 := self findShipReference: arg2.
	tmp1 := tmp1 addToDeck: arg1.
	self updateShipReference: tmp1
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
CardManager >> playCancelCardtargeting: aCard [ 
	| playedCard |
	playedCard := Cancellation new.
	playedCard cancelPlayingCard: aCard using: permanentAppliedCards.
	lastPlayedCard := playedCard.
]

{ #category : 'as yet unclassified' }
CardManager >> replicateEffect: anEffect targeting: aPlayer  using: aGame [
| playedCard |
playedCard :=Repeat new.
playedCard replicateEffect: anEffect targeting: aPlayer  using: aGame.
lastPlayedCard := playedCard.
]
