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

{ #category : 'checking' }
PositionManager >> checkSafeZone: aPlayer [

	^ (self findShipReference: aPlayer) inSafeZone
]

{ #category : 'initialization' }
PositionManager >> initializePlayersPosition: aGroupOfPlayers and: aNumberOfTiles and: aNumberOfLaps [

	playersFeature := aGroupOfPlayers.
	laps := aNumberOfLaps.
	boardLength := aNumberOfTiles
]

{ #category : 'positioning' }
PositionManager >> move: aPlayer with: anAmount [

	| aModifiedPlayer |
	aModifiedPlayer := (self findShipReference: aPlayer) advanceTiles:
		                   anAmount.
	aModifiedPlayer := self checkIfReachedANewLap: aModifiedPlayer.
	self updateShipReference: aModifiedPlayer
]

{ #category : 'checking' }
PositionManager >> playerInSamePositionThan: aPlayer [

	| aPlayerShipPosition |
	aPlayerShipPosition := self findShipReference: aPlayer.
	^ playersFeature select: [ :each |
		  each samePositionAs: aPlayerShipPosition ]
]

{ #category : 'NEEDREVISION' }
PositionManager >> playerPositions [

	| aListOfPositions |
	aListOfPositions := playersFeature collect: [ :player |
		                    'Name: ' , player name , ' , Position: '
		                    , player position asString , ' , Lap: '
		                    , player lap asString ].
	^ aListOfPositions
]

{ #category : 'initialization' }
PositionManager >> resetLapTo: aPlayer [
	| playerToReset |
	playerToReset := self findShipReference: aPlayer.
	self updateShipReference: playerToReset goToFirstTile
]

{ #category : 'checking' }
PositionManager >> stillPlaying [

	^ playersFeature allSatisfy: [ :player | (player lapGreaterThan: laps) not ]
]

{ #category : 'checking' }
PositionManager >> winner [

	| playerWhoWon |
	playerWhoWon := playersFeature
		                detect: [ :player |
		                player lapGreaterThan: laps ]
		                ifNone: [ ^ nil ].
	
	^ playerWhoWon
]
