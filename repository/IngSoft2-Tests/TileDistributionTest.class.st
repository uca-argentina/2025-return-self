Class {
	#name : 'TileDistributionTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aBuilder',
		'aTileListCreator'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
TileDistributionTest >> setUp [

	super setUp.

	aBuilder := TileDistributionBuilder createTileListWith: 101.

	aTileListCreator := TileListCreationForTesting createTileListWith: 5.
]

{ #category : 'tests' }
TileDistributionTest >> test01WhenTryingToCreateATestBoardWithLengthLowerThanThreeThenItRaisesError [

	self
		should: [
			Board createWith:
				{ (Tile createWithEffect: NoEffect new) } ]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]

{ #category : 'tests' }
TileDistributionTest >> test02WhenTryingToCreateABoardWithLengthLowerThanThreeThenItRaisesError [

	self
		should: [ Board createWith: {}]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]

{ #category : 'tests' }
TileDistributionTest >> testBoardBuiltWithBlackHoles [

	| aTestBoard blackHoles noEffect |
	aBuilder addEffectToBuilder: BlackHole.
	aTestBoard := aBuilder buildBoard.

	blackHoles := 0.
	noEffect := 0.
	aTestBoard tiles do: [ :tile |
		(tile effect isBlackHole) ifTrue: [
			blackHoles := blackHoles + 1 ].
		(tile effect isNoEffect) ifTrue: [ noEffect := noEffect + 1 ] ].

	self assert: blackHoles equals: 20.
	self assert: noEffect equals: 79.
]

{ #category : 'tests' }
TileDistributionTest >> testBoardBuiltWithBlackHolesAndAtomikBomb [

	| aTestBoard blackHoles atomikBombs noEffect |
	aBuilder addEffectToBuilder: BlackHole.
	aBuilder addEffectToBuilder: AtomikBomb.
	aTestBoard := aBuilder buildBoard.

	blackHoles := 0.
	atomikBombs := 0.
	noEffect := 0.
	aTestBoard tiles do: [ :tile |
		(tile effect isBlackHole) ifTrue: [
			blackHoles := blackHoles + 1 ].
		(tile effect isNoEffect) ifTrue: [ noEffect := noEffect + 1 ].
		(tile effect isAtomikBomb) ifTrue: [
			atomikBombs := atomikBombs + 1 ] ].


	self assert: blackHoles equals: 20.
	self assert: atomikBombs equals: 2.
	self assert: noEffect equals: 77
]

{ #category : 'tests' }
TileDistributionTest >> testBoardWithEveryThing [

	| aTestBoard blackHoles atomikBombs noEffect hyperJump hyperSpaceJump moonWalk wormhole |
	aBuilder addEveryEffectToBuilder.
	aTestBoard := aBuilder buildBoard.

	blackHoles := 0.
	atomikBombs := 0.
	hyperJump := 0.
	hyperSpaceJump := 0.
	moonWalk := 0.
	noEffect := 0.
	wormhole := 0.
	aTestBoard tiles do: [ :tile |
		tile effect isBlackHole ifTrue: [ blackHoles := blackHoles + 1 ].
		tile effect isNoEffect ifTrue: [ noEffect := noEffect + 1 ].
		tile effect isHyperJump ifTrue: [ hyperJump := hyperJump + 1 ].
		tile effect isHyperSpaceJump ifTrue: [
			hyperSpaceJump := hyperSpaceJump + 1 ].
		tile effect isMoonWalk ifTrue: [ moonWalk := moonWalk + 1 ].
		tile effect isWormhole ifTrue: [ wormhole := wormhole + 1 ].
		tile effect isAtomikBomb ifTrue: [ atomikBombs := atomikBombs + 1 ] ].


	self assert: blackHoles equals: 20.
	self assert: atomikBombs equals: 2.
	self assert: noEffect equals: 39.
	self assert: hyperJump equals: 8.
	self assert: hyperSpaceJump equals: 20.
	self assert: moonWalk equals: 10.
	self assert: wormhole equals: 2
]

{ #category : 'tests' }
TileDistributionTest >> testWhenTryingToCreateTileSetForTestingWithAWormholeWithEndpointOutsideTheBoardLengthThenItRaisesAnError [

	| aWormhole |
	aWormhole := Wormhole createWith: 7.
	
	self
		should: [ aTileListCreator at: 3 put: aWormhole ]
		raiseErrorWithMessageText: 'Wormhole endpoint must be inside.'
]

{ #category : 'tests' }
TileDistributionTest >> testWhenTryingToCreateTileSetForTestingWithAWormholeWithEqualEndsThenItRaisesAnError [

	| aWormhole |
	aWormhole := Wormhole createWith: 3.
	
	self
		should: [ aTileListCreator at: 3 put: aWormhole ]
		raiseErrorWithMessageText: 'Wormhole ends must be different tiles.'
]

{ #category : 'tests' }
TileDistributionTest >> testWhenTryingToCreateTileSetForTestingWithAnEffectInFirstTileThenItRaisesError [

	| aWormhole |
	aWormhole := Wormhole createWith: 3.
	
	self
		should: [ aTileListCreator at: 1 put: aWormhole ]
		raiseErrorWithMessageText: 'Effect cant be in first tile.'
]

{ #category : 'tests' }
TileDistributionTest >> testWhenTryingToCreateTileSetForTestingWithAnEffectOutsideTheBoardLengthThenItRaisesError [

	| aWormhole |
	aWormhole := Wormhole createWith: 3.
	
	self
		should: [ aTileListCreator at: 7 put: aWormhole ]
		raiseErrorWithMessageText: 'Effect cant be outside the board.'
]
