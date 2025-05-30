"
A handler of the turn and game current status with the set of players.
"
Class {
	#name : 'EffectApplicationManager',
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
EffectApplicationManager class >> with: aGroupOfPlayers and: aBoardLength [

	^ self new
		  initializeSetOfPlayers: aGroupOfPlayers
		  andBoard: aBoardLength
]

{ #category : 'instance creation' }
EffectApplicationManager class >> with: aGroupOfPlayers and: aBoardLength and: numberOfLaps [

	^ self new
		  initializeSetOfPlayers: aGroupOfPlayers
		  andBoard: aBoardLength
		  andLaps: numberOfLaps 
]

{ #category : 'comparing' }
EffectApplicationManager >> checkifPlayerStillPlaying: aPlayer [

	^ aPlayer lap < numberOfLaps.
]

{ #category : 'initialization' }
EffectApplicationManager >> initializeSetOfPlayers: aSet andBoard: aBoardLength [

	setOfPlayers := aSet.
	turn := 0.
	boardLength := aBoardLength.
	numberOfLaps := 1.
]

{ #category : 'initialization' }
EffectApplicationManager >> initializeSetOfPlayers: aSet andBoard: aBoardLength andLaps: anAmountOfLaps [

	setOfPlayers := aSet.
	turn := 0.
	boardLength := aBoardLength.
	numberOfLaps := anAmountOfLaps 
]

{ #category : 'play interface' }
EffectApplicationManager >> playTurnUsing: aDistance and: aBoard [

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
	activePlayer := activePlayer circleAroundTheTrackWithLength: aBoard totalTiles .

	setOfPlayers at: self playerInTurnIndex put: activePlayer.
	
	"Mecanica de efecto"
	setOfPlayers := aBoard applyEffectOn: setOfPlayers onIndex: self playerInTurnIndex.
	activePlayer := setOfPlayers at: self playerInTurnIndex.
	^ activePlayer
	
]

{ #category : 'play interface' }
EffectApplicationManager >> playerInTurnIndex [

	^ turn - 1 \\ setOfPlayers size + 1 "The players whose turn is up"
]

{ #category : 'accessing' }
EffectApplicationManager >> setOfPlayers [

	^ setOfPlayers 
]

{ #category : 'accessing' }
EffectApplicationManager >> setOfPlayers: aGroupOfPlayers [
	
	setOfPlayers := aGroupOfPlayers 
]

{ #category : 'play interface' }
EffectApplicationManager >> skipTurn [
	| activePlayer |
	turn := turn + 1.
	activePlayer := setOfPlayers at: self playerInTurnIndex.
	activePlayer:= activePlayer forceAShieldReset.
	
	setOfPlayers at: self playerInTurnIndex put: activePlayer.
	^ activePlayer
	
]

{ #category : 'accessing' }
EffectApplicationManager >> stillPlaying [

	^ setOfPlayers allSatisfy: [ :player |
		  self checkifPlayerStillPlaying: player ]
]

{ #category : 'comparing' }
EffectApplicationManager >> winner [

	| playerWhoWon |
	playerWhoWon := setOfPlayers
		                detect: [ :player |
		                (self checkifPlayerStillPlaying: player) not ]
		                ifNone: [ ^ 'NO ONE WON!' ].
	^ playerWhoWon name
]
