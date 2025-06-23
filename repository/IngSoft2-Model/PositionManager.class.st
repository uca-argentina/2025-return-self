Class {
	#name : 'PositionManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'laps',
		'boardLength',
		'parsecs'
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

	^ self new initializePlayersPosition: playerPositionAssociationGroup and: anNumberOfTiles and: aNumberOfLaps and: 5
]

{ #category : 'creation' }
PositionManager class >> createWith: aGroupOfPlayers and: anNumberOfTiles and: aNumberOfLaps and: parsecsPerTile [

	| playerPositionAssociationGroup |
	self lapHasToBeGreaterThanZero: aNumberOfLaps.
	playerPositionAssociationGroup := aGroupOfPlayers collect: [ :each |
		                              ShipPosition
			                              createWith: each id	
			                              and: 0 ].

	^ self new initializePlayersPosition: playerPositionAssociationGroup and: anNumberOfTiles and: aNumberOfLaps and: parsecsPerTile
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

{ #category : 'checking' }
PositionManager >> checkIfReachedANewPosition: aPlayer [

	(aPlayer parsecGreaterThan: parsecs) ifFalse: [ ^ aPlayer ].
	^ aPlayer changePositionAndCorrectParsecsWith: parsecs
]

{ #category : 'initialization' }
PositionManager >> initializePlayersPosition: aGroupOfPlayers and: aNumberOfTiles and: aNumberOfLaps and: parsecsPerTile [

	playersFeature := aGroupOfPlayers.
	laps := aNumberOfLaps.
	boardLength := aNumberOfTiles.
	parsecs := parsecsPerTile
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

{ #category : 'positioning' }
PositionManager >> move: aPlayer forwardWithParsecs: anAmount [

	| aModifiedPlayer |
	aModifiedPlayer := (self findShipReference: aPlayer) advanceParsecs:
		                   anAmount.
	aModifiedPlayer := self checkIfReachedANewPosition: aModifiedPlayer.
	aModifiedPlayer := self checkIfReachedANewLap: aModifiedPlayer.
	self updateShipReference: aModifiedPlayer
]

{ #category : 'positioning' }
PositionManager >> moveEveryoneExcept: aPlayer backwardsWith: aDistance [

	playersFeature do: [ :player |
		self updateShipReference: (player goBackTiles: aDistance) ].

	self updateShipReference: aPlayer
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
			                    player.
			                    (String streamContents: [ :s |
				                     s nextPutAll: 'Position: '.
				                     s nextPutAll: player position asString.
				                     s nextPutAll: ', Lap: '.
				                     s nextPutAll: player lap asString ]) } ].
	^ aListOfPositions
]

{ #category : 'tests - printing' }
PositionManager >> playerRanking [
	"Used for testing"

	| anOrderListOfPositions |
	anOrderListOfPositions := playersFeature sorted: [ :player :nextOne |
		                          (player
			                           distanceTravelledWith: boardLength
			                           and: parsecs)
		                          >
		                          (nextOne
			                           distanceTravelledWith: boardLength
			                           and: parsecs) ].

	^ anOrderListOfPositions withIndexCollect: [ :player :index |
		  {
			  player id.
			  ('Place: ' , index asString) } ]
]

{ #category : 'positioning' }
PositionManager >> resetLapTo: aPlayer [
	| playerToReset |
	playerToReset := self findShipReference: aPlayer.
	self updateShipReference: playerToReset goToFirstTile
]

{ #category : 'positioning' }
PositionManager >> resetPlayersPosition [

playersFeature do: [ :player | self updateShipReference: player goToFirstTile ].



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
