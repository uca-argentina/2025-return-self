Class {
	#name : 'PlayerManager',
	#superclass : 'GameFeatureManager',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
PlayerManager class >> createWith: aGroupOfPlayers [

	self mustHaveAtLeastTwoPlayers: aGroupOfPlayers.
	self twoPlayersCantHaveTheSameId: aGroupOfPlayers.
	^ self new initializePlayerManagerWith: aGroupOfPlayers
]

{ #category : 'tests - printing' }
PlayerManager >> describeEveryPlayerWith: positionsWithoutName [

	^ playersFeature collect: [ :each |
		each searchReferenceAndConcatName: positionsWithoutName ]
]

{ #category : 'accessing' }
PlayerManager >> everyShip [

	^ playersFeature copy
]

{ #category : 'initialization' }
PlayerManager >> initializePlayerManagerWith: aGroupOfPlayers [

	playersFeature := aGroupOfPlayers
]

{ #category : 'testing' }
PlayerManager >> is: aShip named: aPlayerName [

	^ (self findShipReference: aShip) equalsName: aPlayerName
]

{ #category : 'accessing' }
PlayerManager >> nameOf: aShip [

	^ (self findShipReference: aShip) name
]
