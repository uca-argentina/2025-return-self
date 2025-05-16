Class {
	#name : 'GameplayWithWormhole',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameplayWithWormhole >> testWhenSteppingIntoWormhole [

	| aGame aLoadedDie wormhole|
	wormhole:= (Wormhole oneEnd: 5 otherEnd: 14).
	aLoadedDie := LoadedDie rolling: 4.
	aGame := GameSetup newGameWithDie: aLoadedDie WithWormhole: wormhole .
	

	aGame nextPlayerThrowsDice. 
	"Steps on wormhole here, on next turn it goes through."
	self
		assert: (aGame nextPlayerThrowsDice)
		equals: 14
]
