Class {
	#name : 'GameplayTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameplayTest >> testWhenAGameIsPlayedWithASetOfDie [

	| aGame firstLoadedDice secondLoadedDice aSetOfDie wormhole|
	wormhole:= (Wormhole oneEnd: 5 otherEnd: 14).
	firstLoadedDice := LoadedDie rolling: 3.
	secondLoadedDice := LoadedDie rolling: 5.
	aSetOfDie := DieSet having: {
			             firstLoadedDice.
			             secondLoadedDice }.
	aGame := GameSetup newGameWithDie: aSetOfDie withWormhole: wormhole .

	self
		assert: (aGame nextPlayerThrowsDice)
		equals: 9.
]

{ #category : 'tests' }
GameplayTest >> testWhenAGameStartsTheresTheFirstTurn [

	| aGame aLoadedDie wormhole|
	wormhole:= (Wormhole oneEnd: 3 otherEnd: 14).
	aLoadedDie := LoadedDie rolling: 4.
	aGame := GameSetup newGameWithDie: aLoadedDie withWormhole: wormhole .

	

	self
		assert: (aGame nextPlayerThrowsDice)
		equals: 5.
]

{ #category : 'tests' }
GameplayTest >> testWhenSteppingIntoWormhole [

	| aGame aLoadedDie wormhole|
	wormhole:= (Wormhole oneEnd: 5 otherEnd: 14).
	aLoadedDie := LoadedDie rolling: 4.
	aGame := GameSetup newGameWithDie: aLoadedDie withWormhole: wormhole .
	

	aGame nextPlayerThrowsDice. 
	"Steps on wormhole here, on next turn it goes through."
	self
		assert: (aGame nextPlayerThrowsDice)
		equals: 14
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheSecondTurn [

	| aGame aLoadedDie wormhole|
	wormhole:= (Wormhole oneEnd: 3 otherEnd: 14).
	aLoadedDie := LoadedDie rolling: 4.
	aGame := GameSetup newGameWithDie: aLoadedDie withWormhole: wormhole .
	
	aGame nextPlayerThrowsDice.

	self
		assert: (aGame nextPlayerThrowsDice)
		equals: 5.
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheThirdTurn [

	| aGame aLoadedDie wormhole|
	wormhole:= (Wormhole oneEnd: 3 otherEnd: 14).
	aLoadedDie := LoadedDie rolling: 4.
	aGame := GameSetup newGameWithDie: aLoadedDie withWormhole: wormhole .
	
	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.

	self
		assert: (aGame nextPlayerThrowsDice)
		equals: 9
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGamePlaysItselfThenThereIsAWinner [

	| aGame aLoadedDie wormhole|
	wormhole:= (Wormhole oneEnd: 3 otherEnd: 14).
	aLoadedDie := LoadedDie rolling: 4.
	aGame := GameSetup newGameWithDie: aLoadedDie withWormhole: wormhole .

	aGame playFullGame.

	self assert: aGame whoWon equals: 'Juan'
]

{ #category : 'tests' }
GameplayTest >> testWhenThereIsATurnAfterGameIsFinishedTHenItIsInvalid [

	| aGame aLoadedDie wormhole|
	wormhole:= (Wormhole oneEnd: 3 otherEnd: 14).
	aLoadedDie := LoadedDie rolling: 6.
	aGame := GameSetup newGameWithDie: aLoadedDie withWormhole: wormhole .
	
	aGame playFullGame.
	
	self
		assert: (aGame nextPlayerThrowsDice)
		equals: 'Game is already over.'.

]

{ #category : 'tests' }
GameplayTest >> testWhenTryingToCreateAGameWithAWormholeWhoseOneEndIsOutsideTheBoardLengthItRaisesError [

	| anErrorHandler aWormhole firstPlayer secondPlayer aSetOfPlayers aSetOfDie firstLoadedDice secondLoadedDice |
	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	firstLoadedDice := LoadedDie rolling: 3.
	secondLoadedDice := LoadedDie rolling: 5.
	aSetOfDie := DieSet having: {
			             firstLoadedDice.
			             secondLoadedDice }.
	anErrorHandler := MyErrorHandler usingTestCase: self.

	aWormhole := Wormhole oneEnd: 12 otherEnd: 30.

	anErrorHandler
		should: [
			Game
				playedBy: aSetOfPlayers
				withBoardLength: 20
				withWormhole: aWormhole
				withSetOfDie: aSetOfDie ]
		raise: Error
		withMessageText:
		'Both wormhole ends must be within the board length.'
]
