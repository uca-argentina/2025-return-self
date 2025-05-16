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
	aGame := GameSetup newGameWithDie: aSetOfDie WithWormhole: wormhole .

	self
		assert: (aGame nextPlayerThrowsDice)
		equals: 9.
]

{ #category : 'tests' }
GameplayTest >> testWhenAGameStartsTheresTheFirstTurn [

	| aGame aLoadedDie wormhole|
	wormhole:= (Wormhole oneEnd: 3 otherEnd: 14).
	aLoadedDie := LoadedDie rolling: 4.
	aGame := GameSetup newGameWithDie: aLoadedDie WithWormhole: wormhole .

	

	self
		assert: (aGame nextPlayerThrowsDice)
		equals: 5.
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheSecondTurn [

	| aGame aLoadedDie wormhole|
	wormhole:= (Wormhole oneEnd: 3 otherEnd: 14).
	aLoadedDie := LoadedDie rolling: 4.
	aGame := GameSetup newGameWithDie: aLoadedDie WithWormhole: wormhole .
	
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
	aGame := GameSetup newGameWithDie: aLoadedDie WithWormhole: wormhole .
	
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
	aGame := GameSetup newGameWithDie: aLoadedDie WithWormhole: wormhole .

	aGame playFullGame.

	self assert: aGame whoWon equals: 'Juan WON!'
]

{ #category : 'tests' }
GameplayTest >> testWhenThereIsATurnAfterGameIsFinishedTHenItIsInvalid [

	| aGame aLoadedDie wormhole|
	wormhole:= (Wormhole oneEnd: 3 otherEnd: 14).
	aLoadedDie := LoadedDie rolling: 6.
	aGame := GameSetup newGameWithDie: aLoadedDie WithWormhole: wormhole .
	
	aGame playFullGame.
	
	self
		assert: (aGame nextPlayerThrowsDice)
		equals: 'Game is already over.'.

]
