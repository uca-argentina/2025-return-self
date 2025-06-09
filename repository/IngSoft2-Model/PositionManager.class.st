Class {
	#name : 'PositionManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'laps',
		'boardLength'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
PositionManager class >> createWith: aGroupOfPlayers and: anNumberOfTiles and: aNumberOfLaps [

	| playerPositionAssociationGroup |
	playerPositionAssociationGroup := aGroupOfPlayers collect: [ :each |
		                              ShipPosition
			                              createWith: each id	
			                              and: 0 ].

	^ self new initializePlayersPosition: playerPositionAssociationGroup and: anNumberOfTiles and: aNumberOfLaps
]

{ #category : 'checking' }
PositionManager >> checkIfReachedANewLap: aPlayer [

	(aPlayer positionGreaterThan: boardLength) ifFalse: [ ^ aPlayer ].
	^ aPlayer changeLapAndCorrectPositionWith: boardLength
]

{ #category : 'as yet unclassified' }
PositionManager >> checkSafeZone: aPlayer [

	| playerIndex |
	playerIndex := self findPlayerIndex: aPlayer.
	^ (playersFeature at: playerIndex) inSafeZone
]

{ #category : 'initialization' }
PositionManager >> initializePlayersPosition: aGroupOfPlayers and: aNumberOfTiles and: aNumberOfLaps [

	playersFeature := aGroupOfPlayers.
	laps := aNumberOfLaps.
	boardLength := aNumberOfTiles
]

{ #category : 'positioning' }
PositionManager >> move: aPlayer with: anAmount [

	| aModifiedPlayer playerIndex |
	playerIndex := self findPlayerIndex: aPlayer.
	aModifiedPlayer := (playersFeature at: playerIndex) advanceTiles:
		                   anAmount.
	aModifiedPlayer := self checkIfReachedANewLap: aModifiedPlayer.
	playersFeature at: playerIndex put: aModifiedPlayer
]

{ #category : 'checking' }
PositionManager >> stillPlaying [

	^ playersFeature allSatisfy: [ :player | player lap < laps ]
]

{ #category : 'checking' }
PositionManager >> winner [

	| playerWhoWon |
	playerWhoWon := playersFeature
		                detect: [ :player |
		                player lap >= laps ]
		                ifNone: [ ^ nil ].
	"players findFirst: [ :each | each equals: aPlayer ]"
	^ playerWhoWon
]
