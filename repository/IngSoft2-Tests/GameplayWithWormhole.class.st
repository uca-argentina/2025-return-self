Class {
	#name : 'GameplayWithWormhole',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameplayWithWormhole >> testWhenSteppingIntoWormhole [

	| aGame aSetOfPlayers aBoard aLoadedDie firstPlayer secondPlayer wormhole |
	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	aBoard := Board withLenght: 20.
	wormhole := Wormhole oneEnd: 5 otherEnd: 14.

	aGame := Game
		         playedBy: aSetOfPlayers
		         onBoard: aBoard
		         withWormhole: wormhole.

	aLoadedDie := LoadedDie rolling: 4.
	aGame nextTurn move: aLoadedDie throw. "Goes through wormhole when it lands here, on next turn takes effect."
	aGame nextTurn move: aLoadedDie throw.

	self
		assert: (aGame nextTurn move: aLoadedDie throw)
		equals: 'Juan landed on 18'
]
