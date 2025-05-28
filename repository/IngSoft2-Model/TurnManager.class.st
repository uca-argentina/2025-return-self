"
A handler of the turn and game current status with the set of players.
"
Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'turn',
		'boardLength',
		'setOfPlayers',
		'numberOfLaps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TurnManager class >> with: aSetOfPlayers and: aBoardLength [

	^ self new
		  initializeSetOfPlayers: aSetOfPlayers
		  andBoard: aBoardLength
]

{ #category : 'instance creation' }
TurnManager class >> with: aSetOfPlayers and: aBoardLength and: numberOfLaps [

	^ self new
		  initializeSetOfPlayers: aSetOfPlayers
		  andBoard: aBoardLength
		  andLaps: numberOfLaps 
]

{ #category : 'comparing' }
TurnManager >> checkifPlayerStillPlaying: aPlayer [

	^ aPlayer lap < numberOfLaps.
]

{ #category : 'initialization' }
TurnManager >> initializeSetOfPlayers: aSet andBoard: aBoardLength [

	setOfPlayers := aSet.
	turn := 0.
	boardLength := aBoardLength.
	numberOfLaps := 1.
]

{ #category : 'initialization' }
TurnManager >> initializeSetOfPlayers: aSet andBoard: aBoardLength andLaps: anAmountOfLaps [

	setOfPlayers := aSet.
	turn := 0.
	boardLength := aBoardLength.
	numberOfLaps := anAmountOfLaps 
]

{ #category : 'play interface' }
TurnManager >> playTurnUsing: aDistance and: aWormhole [

	| activePlayer |
	turn := turn + 1.
	activePlayer := setOfPlayers at: self playerInTurnIndex.
	
	[activePlayer skipATurn] whileTrue: [
		setOfPlayers at: self playerInTurnIndex put:(activePlayer turnSkipped ).
		turn := turn + 1.
		activePlayer := setOfPlayers at: self playerInTurnIndex.
		].
	
	activePlayer:= activePlayer resetShieldsAfter2TurnsWithout.
	
	
	activePlayer := activePlayer advanceTiles: aDistance.
	activePlayer := activePlayer circleAroundTheTrackWithLength: boardLength .
	activePlayer := aWormhole applyEffectOn: activePlayer.
	setOfPlayers at: self playerInTurnIndex put: activePlayer.
	^ activePlayer
	
]

{ #category : 'play interface' }
TurnManager >> playerInTurnIndex [

	^ turn - 1 \\ setOfPlayers size + 1 "The players whose turn is up"
]

{ #category : 'accessing' }
TurnManager >> setOfPlayers [

	^ setOfPlayers 
]

{ #category : 'accessing' }
TurnManager >> setOfPlayers: aSetOfPlayers [
	
	setOfPlayers := aSetOfPlayers 
]

{ #category : 'accessing' }
TurnManager >> stillPlaying [

	^ setOfPlayers allSatisfy: [ :player |
		  self checkifPlayerStillPlaying: player ]
]

{ #category : 'comparing' }
TurnManager >> winner [

	| playerWhoWon |
	playerWhoWon := setOfPlayers
		                detect: [ :player |
		                (self checkifPlayerStillPlaying: player) not ]
		                ifNone: [ ^ 'NO ONE WON!' ].
	^ playerWhoWon name
]
