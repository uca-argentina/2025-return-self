Class {
	#name : 'TileTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
TileTest >> testBanana [

| aPosition anEffect aTile |
aPosition := 1.
anEffect := NoEffect new.

aTile := Tile createWithPosition: aPosition andEffect: anEffect.
]

{ #category : 'tests' }
TileTest >> testWhenTryingToCreateATileWithNegativeParsecThenItRaisesError [

	| aPosition anEffect |
	aPosition := -2.
	anEffect := NoEffect new.

	self
		should: [ Tile createWithPosition: aPosition andEffect: anEffect ]
		raiseErrorWithMessageText: 'a tile must have positive parsecs'
]
