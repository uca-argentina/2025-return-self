Class {
	#name : 'CardManager',
	#superclass : 'GameFeatureManager',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardManager class >> createWith: aGroupOfPlayers [

	| playerCardAssociationGroup |
	playerCardAssociationGroup := aGroupOfPlayers collect: [ :each |
		                              ShipCards
			                              createWith: each id
			                              and: OrderedCollection new ].
	^ self new initializeCardManagerWith: playerCardAssociationGroup
]

{ #category : 'adding' }
CardManager >> add: aCard to: aPlayer [

	| ship |
	ship := self findShipReference: aPlayer.
	ship addToDeck: aCard create.
	self updateShipReference: ship.
]

{ #category : 'initialization' }
CardManager >> initializeCardManagerWith: aGroupOfPlayers [

	playersFeature := aGroupOfPlayers
]
