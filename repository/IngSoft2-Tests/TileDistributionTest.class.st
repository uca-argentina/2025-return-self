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
TileDistributionTest >> test001BoardBuiltWithBlackHoles [

	| aTestBoard |
	aBuilder addEffectToBuilder: BlackHole.
	aTestBoard := aBuilder buildBoard.
	self assert: (self amountOf: BlackHole in: aTestBoard) equals: 18.
	self assert: (self amountOf: NoEffect in: aTestBoard) equals: 81
]

{ #category : 'tests' }
TileDistributionTest >> test002BoardBuiltWithBlackHolesAndAtomikBomb [

	| aTestBoard |
	aBuilder addEffectToBuilder: BlackHole.
	aBuilder addEffectToBuilder: AtomikBomb.
	aTestBoard := aBuilder buildBoard.
	self assert: (self amountOf: BlackHole in: aTestBoard) equals: 18.
	self assert: (self amountOf: AtomikBomb in: aTestBoard) equals: 2.
	self assert: (self amountOf: NoEffect in: aTestBoard) equals: 79
]

{ #category : 'tests' }
TileDistributionTest >> test003BoardWithEveryThing [

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
TileDistributionTest >> test004WhenTryingToCreateATestBoardWithLengthLowerThanThreeThenItRaisesError [

	self
		should: [
			Board createWith:
				{ (Tile createWithEffect: NoEffect new) } ]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]

{ #category : 'tests' }
TileDistributionTest >> test005WhenTryingToCreateABoardWithLengthLowerThanThreeThenItRaisesError [

	self
		should: [ Board createWith: {}]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]

{ #category : 'tests' }
TileDistributionTest >> test006WhenTryingToCreateTileSetForTestingWithAWormholeWithEqualEndsThenItRaisesAnError [

	| aWormhole |
	aWormhole := Wormhole createWith: 3.

	self
		should: [ aTileListCreator at: 3 put: aWormhole ]
		raiseErrorWithMessageText: 'Wormhole ends must be different tiles.'
]

{ #category : 'tests' }
TileDistributionTest >> test007WhenTryingToCreateTileSetForTestingWithAWormholeWithEndpointOutsideTheBoardLengthThenItRaisesAnError [

	| aWormhole |
	aWormhole := Wormhole createWith: 7.

	self
		should: [ aTileListCreator at: 3 put: aWormhole ]
		raiseErrorWithMessageText: 'Wormhole endpoint must be inside.'
]

{ #category : 'tests' }
TileDistributionTest >> test008WhenTryingToCreateTileSetForTestingWithAnEffectInFirstTileThenItRaisesError [

	| aWormhole |
	aWormhole := Wormhole createWith: 3.

	self
		should: [ aTileListCreator at: 1 put: aWormhole ]
		raiseErrorWithMessageText: 'Effect cant be in first tile.'
]

{ #category : 'tests' }
TileDistributionTest >> test009WhenTryingToCreateTileSetForTestingWithAnEffectOutsideTheBoardLengthThenItRaisesError [

	| aWormhole |
	aWormhole := Wormhole createWith: 3.

	self
		should: [ aTileListCreator at: 7 put: aWormhole ]
		raiseErrorWithMessageText: 'Effect cant be outside the board.'
]

{ #category : 'tests' }
TileDistributionTest >> test010BoardBuiltWithATotalLengthInLightYearsSplitsItEvenlyAmongItsTiles [

	| aTestBoard |
	aTestBoard := (TileDistributionBuilder
					   createTileListWith: 10
					   withTotalLength: (LightYears of: 150)) buildBoard.
	self assert: aTestBoard parsecsPerTile equals: 5
]

{ #category : 'tests' }
TileDistributionTest >> test011WhenTryingToCreateATileWithoutLengthThenItRaisesError [

	self
		should: [ Tile createWithEffect: NoEffect create and: (Parsecs of: 0) ]
		raiseErrorWithMessageText: 'A tile must be longer than zero parsecs.'
]

{ #category : 'tests' }
TileDistributionTest >> test012WhenTryingToCreateABoardWithAWormholeThatLeadsOutsideOfItThenItRaisesError [

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
TileDistributionTest >> test013WhenTryingToCreateABoardWithTilesOfDifferentLengthsThenItRaisesError [

	| someTiles |
	someTiles := {
					 (Tile createWithEffect: NoEffect create and: (Parsecs of: 5)).
					 (Tile createWithEffect: NoEffect create and: (Parsecs of: 5)).
					 (Tile createWithEffect: NoEffect create and: (LightYears of: 9)).
					 (Tile createWithEffect: NoEffect create and: (Parsecs of: 5)) }.
	self
		should: [ Board createWith: someTiles ]
		raiseErrorWithMessageText: 'Every tile of the board must have the same length.'
]

{ #category : 'tests' }
TileDistributionTest >> test014TheProbabilitiesOfTheEmptyTileAndOfEveryEffectAddUpToOneHundredPercent [

	| everyKindOfTile total |
	everyKindOfTile := {
						   NoEffect.
						   AtomikBomb.
						   BlackHole.
						   CardGiver.
						   HyperJump.
						   HyperSpaceJump.
						   MoonWalk }.
	total := everyKindOfTile
				 inject: 0
				 into: [ :sum :effect | sum + effect effectProbability ].
	self assert: (total * 100) rounded equals: 100
]
