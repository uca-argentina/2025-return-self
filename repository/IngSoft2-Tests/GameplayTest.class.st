Class {
	#name : 'GameplayTest',
	#superclass : 'TestCase',
	#instVars : [
		'firstPlayer',
		'secondPlayer',
		'aSetOfPlayers'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameplayTest >> setUp [
	super setUp.

	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }
]

{ #category : 'tests' }
GameplayTest >> testGamePlayedWithASingleLap [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aWormhole
		         withSetOfDie: aLoadedDie
					withLaps: 1.
					
	aGame playFullGame.

	self assert: aGame winner equals: 'Juan'
"
	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.

	self assert: aGame nextPlayerThrowsDice equals: 9"
]

{ #category : 'tests' }
GameplayTest >> testGamePlayedWithATwoLaps [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 4.
	aLoadedDie := LoadedDie rolling: 6.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 5
		         withEffect: aWormhole
		         withSetOfDie: aLoadedDie
					withLaps: 2.
	
	self assert: aGame nextPlayerThrowsDice equals: 2
]

{ #category : 'tests' }
GameplayTest >> testWhenAGameIsPlayedWithASetOfDie [

	| aGame firstLoadedDice secondLoadedDice aWormhole aSetOfDie |
	aWormhole := Wormhole oneEnd: 5 otherEnd: 14.
	firstLoadedDice := LoadedDie rolling: 3.
	secondLoadedDice := LoadedDie rolling: 5.
	aSetOfDie := DieSet having: {
			             firstLoadedDice.
			             secondLoadedDice }.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aWormhole
		         withSetOfDie: aSetOfDie.
	self assert: aGame nextPlayerThrowsDice equals: 9
]

{ #category : 'tests' }
GameplayTest >> testWhenAGameStartsTheresTheFirstTurn [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aWormhole
		         withSetOfDie: aLoadedDie.



	self assert: aGame nextPlayerThrowsDice equals: 5
]

{ #category : 'tests' }
GameplayTest >> testWhenSteppingIntoWormhole [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 5 otherEnd: 14.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aWormhole
		         withSetOfDie: aLoadedDie.


	aGame nextPlayerThrowsDice.
	"Steps on wormhole here, on next turn it goes through."
	self assert: aGame nextPlayerThrowsDice equals: 14
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheSecondTurn [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aWormhole
		         withSetOfDie: aLoadedDie.

	aGame nextPlayerThrowsDice.

	self assert: aGame nextPlayerThrowsDice equals: 5
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheThirdTurn [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aWormhole
		         withSetOfDie: aLoadedDie.

	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.

	self assert: aGame nextPlayerThrowsDice equals: 9
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGamePlaysItselfThenThereIsAWinner [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aWormhole
		         withSetOfDie: aLoadedDie.

	aGame playFullGame.

	self assert: aGame winner equals: 'Juan'
]

{ #category : 'tests' }
GameplayTest >> testWhenThereIsATurnAfterGameIsFinishedTHenItIsInvalid [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aLoadedDie := LoadedDie rolling: 6.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aWormhole
		         withSetOfDie: aLoadedDie.

	aGame playFullGame.

	self assert: aGame nextPlayerThrowsDice equals: aGame
]

{ #category : 'tests' }
GameplayTest >> testWhenTryingToCreateAGameWithABoardLengthLowerThanThreeThenItRaisesError [

	| anErrorHandler aWormhole aFirstPlayer aSecondPlayer anotherSetOfPlayers aSetOfDie firstLoadedDice secondLoadedDice |
	aFirstPlayer := Player named: 'Juan'.
	aSecondPlayer := Player named: 'Tomi'.
	anotherSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	firstLoadedDice := LoadedDie rolling: 3.
	secondLoadedDice := LoadedDie rolling: 5.
	aSetOfDie := DieSet having: {
			             firstLoadedDice.
			             secondLoadedDice }.
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.

	aWormhole := Wormhole oneEnd: 2 otherEnd: 3.

	anErrorHandler
		should: [
			Game
				playedBy: aSetOfPlayers
				withBoardLength: 3
				withEffect: aWormhole
				withSetOfDie: aSetOfDie ]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]

{ #category : 'tests' }
GameplayTest >> testWhenTryingToCreateAGameWithAWormholeWhoseOneEndIsOutsideTheBoardLengthItRaisesError [

	| anErrorHandler aWormhole aFirstPlayer aSecondPlayer anotherSetOfPlayers aSetOfDie firstLoadedDice secondLoadedDice |
	aFirstPlayer := Player named: 'Juan'.
	aSecondPlayer := Player named: 'Tomi'.
	anotherSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	firstLoadedDice := LoadedDie rolling: 3.
	secondLoadedDice := LoadedDie rolling: 5.
	aSetOfDie := DieSet having: {
			             firstLoadedDice.
			             secondLoadedDice }.
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.

	aWormhole := Wormhole oneEnd: 12 otherEnd: 30.

	anErrorHandler
		should: [
			Game
				playedBy: aSetOfPlayers
				withBoardLength: 20
				withEffect: aWormhole
				withSetOfDie: aSetOfDie ]
		raiseErrorWithMessageText:
		'Both wormhole ends must be within the board length.'
]

{ #category : 'tests' }
GameplayTest >> testWhenTryingToUseGameSetupWithAWormholeWhoseOneEndIsOutsideTheBoardLengthItRaisesError [

	| anErrorHandler aWormhole aSetOfDie firstLoadedDice secondLoadedDice aLoadedDie |
	firstLoadedDice := LoadedDie rolling: 3.
	secondLoadedDice := LoadedDie rolling: 5.
	aSetOfDie := DieSet having: {
			             firstLoadedDice.
			             secondLoadedDice }.
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.

	aWormhole := Wormhole oneEnd: 12 otherEnd: 30.
	aLoadedDie := LoadedDie rolling: 4.
	anErrorHandler
		should: [
			Game
				playedBy: aSetOfPlayers
				withBoardLength: 20
				withEffect: aWormhole
				withSetOfDie: aLoadedDie ]
		raiseErrorWithMessageText:
		'Both wormhole ends must be within the board length.'
]
