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

{ #category : 'private' }
TileDistributionTest >> amountOf: anEffectClass in: aBoard [

	^ aBoard tiles count: [ :tile | tile effect class = anEffectClass ]
]

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
TileDistributionTest >> testBoardBuiltWithATotalLengthInLightYearsSplitsItEvenlyAmongItsTiles [

	| aTestBoard |
	aTestBoard := (TileDistributionBuilder
					   createTileListWith: 10
					   withTotalLength: (LightYears of: 150)) buildBoard.
	self assert: aTestBoard parsecsPerTile equals: 5
]

{ #category : 'tests' }
TileDistributionTest >> testBoardBuiltWithBlackHoles [

	| aTestBoard |
	aBuilder addEffectToBuilder: BlackHole.
	aTestBoard := aBuilder buildBoard.
	self assert: (self amountOf: BlackHole in: aTestBoard) equals: 18.
	self assert: (self amountOf: NoEffect in: aTestBoard) equals: 81
]

{ #category : 'tests' }
TileDistributionTest >> testBoardBuiltWithBlackHolesAndAtomikBomb [

	| aTestBoard |
	aBuilder addEffectToBuilder: BlackHole.
	aBuilder addEffectToBuilder: AtomikBomb.
	aTestBoard := aBuilder buildBoard.
	self assert: (self amountOf: BlackHole in: aTestBoard) equals: 18.
	self assert: (self amountOf: AtomikBomb in: aTestBoard) equals: 2.
	self assert: (self amountOf: NoEffect in: aTestBoard) equals: 79
]

{ #category : 'tests' }
TileDistributionTest >> testBoardWithEveryThing [

	| aTestBoard |
	aBuilder addEveryEffectToBuilder.
	aTestBoard := aBuilder buildBoard.
	self assert: (self amountOf: BlackHole in: aTestBoard) equals: 18.
	self assert: (self amountOf: AtomikBomb in: aTestBoard) equals: 2.
	self assert: (self amountOf: NoEffect in: aTestBoard) equals: 37.
	self assert: (self amountOf: HyperJump in: aTestBoard) equals: 6.
	self assert: (self amountOf: HyperSpaceJump in: aTestBoard) equals: 18.
	self assert: (self amountOf: MoonWalk in: aTestBoard) equals: 8.
	self assert: (self amountOf: CardGiver in: aTestBoard) equals: 10.
	self assert: (self amountOf: Wormhole in: aTestBoard) equals: 2
]

{ #category : 'tests' }
TileDistributionTest >> testWhenTryingToCreateABoardWithAWormholeThatLeadsOutsideOfItThenItRaisesError [

	| someTiles |
	someTiles := {
					 (Tile createWithEffect: NoEffect create).
					 (Tile createWithEffect: (Wormhole createWith: 9)).
					 (Tile createWithEffect: NoEffect create).
					 (Tile createWithEffect: NoEffect create) }.
	self
		should: [ Board createWith: someTiles ]
		raiseErrorWithMessageText: 'Wormhole endpoint must be inside.'
]

{ #category : 'tests' }
TileDistributionTest >> testWhenTryingToCreateATileWithoutLengthThenItRaisesError [

	self
		should: [ Tile createWithEffect: NoEffect create and: (Parsecs of: 0) ]
		raiseErrorWithMessageText: 'A tile must be longer than zero parsecs.'
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
