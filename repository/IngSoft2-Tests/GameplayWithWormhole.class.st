Class {
	#name : 'GameplayWithWormhole',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameplayWithWormhole >> testWhenSteppingIntoWormhole [

	| aGame aLoadedDie  |
	
	aGame := GameSetup newGameWithWormhole: (Wormhole oneEnd: 5 otherEnd: 14).

	aLoadedDie := LoadedDie rolling: 4.
	aGame nextTurn move: aLoadedDie throw. "Goes through wormhole when it lands here, on next turn takes effect."
	aGame nextTurn move: aLoadedDie throw.

	self
		assert: (aGame nextTurn move: aLoadedDie throw)
		equals: 'Juan landed on 18'
]
