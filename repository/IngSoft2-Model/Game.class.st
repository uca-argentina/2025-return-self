"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'setOfDie',
		'board',
		'turnManager',
		'battleManager',
		'positionManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Game class >> mustHaveAtLeastOneDieToPlay: aSetOfDie [

	aSetOfDie isEmpty ifTrue: [ Error signal: 'You must have at least one die to play.' ]
]

{ #category : 'creation' }
Game class >> playedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps [

	| aGroupOfXPlayers |
	aGroupOfXPlayers := aGroupOfPlayers asOrderedCollection.
	self mustHaveAtLeastTwoPlayers: aGroupOfXPlayers.
	self twoPlayersCantHaveTheSameId: aGroupOfXPlayers.
	self mustHaveAtLeastOneDieToPlay: aSetOfDie asOrderedCollection.
	^ self new
		  initializePlayedBy: aGroupOfXPlayers asArray
		  withBoard: aBoard
		  withSetOfDie: aSetOfDie
		  withLaps: laps
]

{ #category : 'checking' }
Game >> checkIfBattle: activePlayer [

	| playersToEngage playerWhoLost |
	playersToEngage := positionManager playerInSamePositionThan:
		                   activePlayer.
	playersToEngage size = 2 ifFalse: [ ^ self ].
	playerWhoLost := battleManager
		                 engage: playersToEngage
		                 inBattleUsing: setOfDie.
	playerWhoLost needsRecovery ifTrue: [
		turnManager addTwoSkipsTo: playerWhoLost ].
	positionManager resetLapTo: playerWhoLost
]

{ #category : 'checking' }
Game >> checkIfRecoveryNeeded: aPlayer [

	turnManager checkNoTurnsToSkip ifTrue: [ battleManager resetShieldsIfNeeded: aPlayer ]
]

{ #category : 'initialization' }
Game >> initializePlayedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: anAmountOfLaps [

	turnManager := TurnManager createWith: aGroupOfPlayers.
	battleManager := BattleManager createWith: aGroupOfPlayers.
	positionManager := PositionManager createWith: aGroupOfPlayers and: aBoard totalTiles and: anAmountOfLaps.
	setOfDie := aSetOfDie.
	board := aBoard.
	playersFeature := aGroupOfPlayers
]

{ #category : 'testing' }
Game >> isWinner: aPlayerName [
	"Used for testing"

	| aPlayer |
	aPlayer := self findShipReference: positionManager winner.
	^ aPlayer equalsName: aPlayerName
]

{ #category : 'interaction loop' }
Game >> nextPlayerSkipsTurn [

	| activePlayer |
	positionManager stillPlaying ifFalse: [ ^ self findShipReference: positionManager winner ].
	turnManager nextPlayerTurnBegins.
	activePlayer := turnManager playerInTurn.
	battleManager forceAShieldReset: activePlayer.
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [

	| activePlayer activePlayerIndex |
	activePlayerIndex := 'PARA QUE NO ROMPA LOS HUEVOS EN LOS COMMIT, DESPUES LO BORRAMOS'.
	positionManager stillPlaying ifFalse: [ ^ self findShipReference: positionManager winner ].

	"---Turno---"
	turnManager playNextTurn.
	activePlayer := turnManager playerInTurn.

	"---Resetea, si es necesario, los escudos luego de los dos turnos de penalizacion---"
	self checkIfRecoveryNeeded: activePlayer.

	"---Avanza con la tirada---"
	positionManager move: activePlayer forwardWith: setOfDie throw.

	"---Aplicacion de efecto---"
	"VERIFICAR EN LA BRANCH QUE FALTA, quizas meta que el check anterior"
	"me devuelva la lista de los shipshields para poder pasarsela al board, aunque"
	"capaz me convenga simplemente pasar el Game"
	
	playersFeature := board
		                  applyEffectTriggeredByPlayerAt: activePlayerIndex
		                  to: playersFeature.

	"---Batalla---"
	(positionManager checkSafeZone: activePlayer) ifFalse: [
		self checkIfBattle: activePlayer ].
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[ positionManager stillPlaying ] whileTrue: [ self nextPlayerThrowsDice ]
]

{ #category : 'tests - printing' }
Game >> playerPositions [
	"Used for testing"

	| positionsWithoutName |
	positionsWithoutName := positionManager playerPositions.
	^ playersFeature collect: [ :each |
		  each searchReferenceAndConcatName: positionsWithoutName ]
]

{ #category : 'testing' }
Game >> positionFeatureOf: aShip [
	"Used for testing"

	^ positionManager findShipReference: aShip
]

{ #category : 'testing' }
Game >> shieldsFeatureOf: aShip [
	"Used for testing"

	^ battleManager findShipReference: aShip
]

{ #category : 'testing' }
Game >> turnsFeatureOf: aShip [
	"Used for testing"

	^ turnManager findShipReference: aShip
]
