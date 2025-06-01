"
A handler of the turn and game current status with the set of players.
"
Class {
	#name : 'EffectApplicationManager',
	#superclass : 'Object',
	#instVars : [
		'turn',
		'boardLength',
		'numberOfLaps',
		'players'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
EffectApplicationManager class >> with: aGroupOfPlayers and: aBoardLength [

	^ self new
		  initializePlayers: aGroupOfPlayers
		  andBoard: aBoardLength
]

{ #category : 'instance creation' }
EffectApplicationManager class >> with: aGroupOfPlayers and: aBoardLength and: numberOfLaps [

	^ self new
		  initializePlayers: aGroupOfPlayers
		  andBoard: aBoardLength
		  andLaps: numberOfLaps 
]

{ #category : 'initialization' }
EffectApplicationManager >> initializePlayers: aGroup andBoard: aBoardLength [

	players := aGroup.
	turn := 0.
	boardLength := aBoardLength.
	numberOfLaps := 1.
]

{ #category : 'initialization' }
EffectApplicationManager >> initializePlayers: aGroup andBoard: aBoardLength andLaps: anAmountOfLaps [

	players := aGroup.
	turn := 0.
	boardLength := aBoardLength.
	numberOfLaps := anAmountOfLaps 
]

{ #category : 'play interface' }
EffectApplicationManager >> playTurnUsing: aDistance and: aBoard [

	| activePlayer |
	turn := turn + 1.
	activePlayer := players at: self playerInTurnIndex.
	
	[activePlayer skipATurn] whileTrue: [
		players at: self playerInTurnIndex put:(activePlayer turnSkipped ).
		turn := turn + 1.
		activePlayer := players at: self playerInTurnIndex.
		].
	
	activePlayer:= activePlayer resetShieldsAfter2TurnsWithout.
	
	
	activePlayer := activePlayer advanceTiles: aDistance.
	activePlayer := activePlayer circleAroundTheTrackWithLength: aBoard totalTiles .

	players at: self playerInTurnIndex put: activePlayer.
	
	"Mecanica de efecto"
	players := aBoard applyEffectTriggeredBy: self playerInTurnIndex.
	activePlayer := players at: self playerInTurnIndex.
	^ activePlayer
	
]

{ #category : 'play interface' }
EffectApplicationManager >> playerInTurnIndex [

	^ turn - 1 \\ players size + 1 "The players whose turn is up"
]

{ #category : 'accessing' }
EffectApplicationManager >> setOfPlayers [

	^ players 
]

{ #category : 'accessing' }
EffectApplicationManager >> setOfPlayers: aGroupOfPlayers [
	
	players := aGroupOfPlayers 
]

{ #category : 'play interface' }
EffectApplicationManager >> skipTurn [
	| activePlayer |
	turn := turn + 1.
	activePlayer := players at: self playerInTurnIndex.
	activePlayer:= activePlayer forceAShieldReset.
	
	players at: self playerInTurnIndex put: activePlayer.
	^ activePlayer
	
]

{ #category : 'comparing' }
EffectApplicationManager >> winner [

	| playerWhoWon |
	playerWhoWon := players
		                detect: [ :player |
		                (self checkifPlayerStillPlaying: player) not ]
		                ifNone: [ ^ 'NO ONE WON!' ].
	^ playerWhoWon name
]
