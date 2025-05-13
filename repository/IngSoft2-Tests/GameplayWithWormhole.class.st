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
	aGame nextPlayerThrowsDice: aLoadedDie .

	self
		assert: (aGame nextPlayerThrowsDice: aLoadedDie )
		equals: 'Juan entered wormhole on 5 and came out from 14 - Then Juan landed on 18'
]
