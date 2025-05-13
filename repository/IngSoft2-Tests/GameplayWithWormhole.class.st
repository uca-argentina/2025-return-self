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
	aGame nextPlayerThrowsDice: aLoadedDie . 
	"Steps on wormhole here, on next turn it goes through."
	self
		assert: (aGame nextPlayerThrowsDice: aLoadedDie )
		equals: 14
]
