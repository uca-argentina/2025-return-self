Class {
	#name : 'GameplayTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameplayTest >> testTryingToMoveWhenTheGameIsOver [

	| aGame aLoadedDie |
	
	aGame := GameSetup newGame.

	aLoadedDie := LoadedDie rolling: 6.
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .

	self
		assert: (aGame nextPlayerThrowsDice: aLoadedDie )
		equals: 'Game is already over.'.
	self assert: aGame whoWon equals: 'Juan WON!'
]

{ #category : 'tests' }
GameplayTest >> testWhenAGameIsPlayedWithASetOfDie [

	| aGame firstLoadedDice secondLoadedDice aSetOfDie |
	
	aGame := GameSetup newGame.

	firstLoadedDice := LoadedDie rolling: 3.
	secondLoadedDice := LoadedDie rolling: 5.
	aSetOfDie := DieSet having: {
			             firstLoadedDice.
			             secondLoadedDice }.

	self
		assert: (aGame nextPlayerThrowsDice: aSetOfDie )
		equals: 'Juan landed on 9'
]

{ #category : 'tests' }
GameplayTest >> testWhenAGameStartsTheresTheFirstTurn [

	| aGame aLoadedDie |
	aGame := GameSetup newGame.

	aLoadedDie := LoadedDie rolling: 4.

	self
		assert: (aGame nextPlayerThrowsDice: aLoadedDie )
		equals: 'Juan landed on 5'
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheSecondTurn [

	| aGame aLoadedDie |
	
	aGame := GameSetup newGame.

	aLoadedDie := LoadedDie rolling: 4.
	aGame nextPlayerThrowsDice: aLoadedDie.

	self
		assert: (aGame nextPlayerThrowsDice: aLoadedDie)
		equals: 'Tomi landed on 5'
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheThirdTurn [

	| aGame aLoadedDie |
	
	aGame := GameSetup newGame.

	aLoadedDie := LoadedDie rolling: 4.
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .

	self
		assert: (aGame nextPlayerThrowsDice: aLoadedDie )
		equals: 'Juan landed on 9'
]

{ #category : 'tests' }
GameplayTest >> testWhenThereIsAWinner [

	| aGame aLoadedDie |
	
	aGame := GameSetup newGame.

	aLoadedDie := LoadedDie rolling: 6.
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .
	aGame nextPlayerThrowsDice: aLoadedDie .

	self
		assert: (aGame nextPlayerThrowsDice: aLoadedDie )
		equals: 'Juan landed on 25'.
	self assert: aGame whoWon equals: 'Juan WON!'
]
