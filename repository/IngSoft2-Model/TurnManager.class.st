"
A handler of the turn and game current status with the set of players.
"
Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'turn',
		'boardLength',
		'setOfPlayers'
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

{ #category : 'comparing' }
TurnManager >> checkifPlayerStillPlaying: aPlayer [

	^ aPlayer position < boardLength
]

{ #category : 'initialization' }
TurnManager >> initializeSetOfPlayers: aSet andBoard: aBoardLength [

	setOfPlayers := aSet.
	turn := 0.
	boardLength := aBoardLength
]

{ #category : 'play interface' }
TurnManager >> playTurnUsing: aDistance and: aWormhole [

	| activePlayer |
	turn := turn + 1.
	activePlayer := setOfPlayers at: self playerInTurnIndex.
	activePlayer := activePlayer advanceTiles: aDistance.
	activePlayer := aWormhole applyEffectOn: activePlayer.
	setOfPlayers at: self playerInTurnIndex put: activePlayer.
	^ activePlayer
]

{ #category : 'play interface' }
TurnManager >> playerInTurnIndex [

	^ turn - 1 \\ setOfPlayers size + 1 "The players whose turn is up"
]

{ #category : 'accessing' }
TurnManager >> stillPlaying [

	^ setOfPlayers allSatisfy: [ :player |
		  self checkifPlayerStillPlaying: player ]
]

{ #category : 'comparing' }
TurnManager >> whoWon [

	| playerWhoWon |
	playerWhoWon := setOfPlayers
		                detect: [ :player |
		                (self checkifPlayerStillPlaying: player) not ]
		                ifNone: [ ^ 'NO ONE WON!' ].
	^ playerWhoWon name
]
