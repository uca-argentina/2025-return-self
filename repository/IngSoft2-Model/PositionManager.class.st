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
	self lapHasToBeGreaterThanZero: aNumberOfLaps.
	playerPositionAssociationGroup := aGroupOfPlayers collect: [ :each |
		                              ShipPosition
			                              createWith: each id	
			                              and: 0 ].

	^ self new initializePlayersPosition: playerPositionAssociationGroup and: anNumberOfTiles and: aNumberOfLaps
]

{ #category : 'testing' }
PositionManager class >> lapHasToBeGreaterThanZero: aNumberOfLaps [

	aNumberOfLaps > 0 ifFalse: [
		Error signal:
			'The amount of laps cannot be lower than 1.' ]
]

{ #category : 'checking' }
PositionManager >> checkIfBattle: aPlayer [

	^ (self findShipReference: aPlayer) inSafeZone not and:
		  (self playerInSamePositionThan: aPlayer) size = 2
]

{ #category : 'checking' }
PositionManager >> checkIfReachedANewLap: aPlayer [

	(aPlayer positionGreaterThan: boardLength) ifFalse: [ ^ aPlayer ].
	^ aPlayer changeLapAndCorrectPositionWith: boardLength
]

{ #category : 'initialization' }
PositionManager >> initializePlayersPosition: aGroupOfPlayers and: aNumberOfTiles and: aNumberOfLaps [

	playersFeature := aGroupOfPlayers.
	laps := aNumberOfLaps.
	boardLength := aNumberOfTiles
]

{ #category : 'positioning' }
PositionManager >> move: aPlayer backwardWith: anAmount [

	| aModifiedPlayer |
	aModifiedPlayer := (self findShipReference: aPlayer) goBackTiles:
		                   anAmount.
	self updateShipReference: aModifiedPlayer
]

{ #category : 'positioning' }
PositionManager >> move: aPlayer forwardWith: anAmount [

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

{ #category : 'tests - printing' }
PositionManager >> playerPositions [
	"Used for testing"

	| aListOfPositions |
	aListOfPositions := playersFeature collect: [ :player |
		                    {
			                    player id.
			                    ('Position: ' , player position asString
			                     , ', Lap: ' , player lap asString) } ].
	^ aListOfPositions
]

{ #category : 'tests - printing' }
PositionManager >> playerRanking [
	"Used for testing"

	| anOrderListOfPositions |
	anOrderListOfPositions := playersFeature sorted: [ :player :nextOne |
		                          (player distanceTravelledWith: boardLength)
		                          >
		                          (nextOne distanceTravelledWith:
			                           boardLength) ].

	^ anOrderListOfPositions withIndexCollect: [ :player :index |
		  {
			  player id.
			  ('Place: ' , index asString) } ]
]

{ #category : 'initialization' }
PositionManager >> resetLapTo: aPlayer [
	| playerToReset |
	playerToReset := self findShipReference: aPlayer.
	self updateShipReference: playerToReset goToFirstTile
]

{ #category : 'checking' }
PositionManager >> stillPlaying [

	^ playersFeature allSatisfy: [ :player | (player lapGreaterOrEqualThan: laps) not ]
]

{ #category : 'checking' }
PositionManager >> winner [

	| playerWhoWon |
	playerWhoWon := playersFeature
		                detect: [ :player |
		                player lapGreaterOrEqualThan: laps ]
		                ifNone: [ Error signal: 'There is no winner yet.' ].
	
	^ playerWhoWon
]
