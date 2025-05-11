Class {
	#name : 'GameplayTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameplayTest >> testWhenAGameStartsTheresTheFirstTurn [

| aGame aSetOfPlayers aBoard aLoadedDie firstPlayer secondPlayer|
firstPlayer := Player named: 'Juan'.
secondPlayer := Player named: 'Tomi'.
aSetOfPlayers := { firstPlayer . secondPlayer}.
aBoard:= Board withLenght: 20.

aGame := Game playedBy: aSetOfPlayers onBoard: aBoard.

aLoadedDie := LoadedDie rolling: 4.

self assert:(aGame nextTurn move: (aLoadedDie throw)) equals: 'Juan landed on 5' .

]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheSecondTurn [

| aGame aSetOfPlayers aBoard aLoadedDie firstPlayer secondPlayer|
firstPlayer := Player named: 'Juan'.
secondPlayer := Player named: 'Tomi'.
aSetOfPlayers := { firstPlayer . secondPlayer}.
aBoard:= Board withLenght: 20.

aGame := Game playedBy: aSetOfPlayers onBoard: aBoard.

aLoadedDie := LoadedDie rolling: 4.
aGame nextTurn move: (aLoadedDie throw).

self assert:(aGame nextTurn move: (aLoadedDie throw)) equals: 'Tomi landed on 5' .
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheThirdTurn [

| aGame aSetOfPlayers aBoard aLoadedDie firstPlayer secondPlayer|
firstPlayer := Player named: 'Juan'.
secondPlayer := Player named: 'Tomi'.
aSetOfPlayers := { firstPlayer . secondPlayer}.
aBoard:= Board withLenght: 20.

aGame := Game playedBy: aSetOfPlayers onBoard: aBoard.

aLoadedDie := LoadedDie rolling: 4.
aGame nextTurn move: (aLoadedDie throw).
aGame nextTurn move: (aLoadedDie throw).

self assert:(aGame nextTurn move: (aLoadedDie throw)) equals: 'Juan landed on 9' .
]
