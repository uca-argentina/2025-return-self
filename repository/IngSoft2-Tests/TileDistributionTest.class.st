Class {
	#name : 'TileDistributionTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aGroupOfPlayers'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
TileDistributionTest >> setUp [

	super setUp.
	aGroupOfPlayers := {
		                   (ShipPlayerAssociation createWith: 1 and: 'Juan').
		                   (ShipPlayerAssociation createWith: 2 and: 'Tomi') }
]

{ #category : 'tests' }
TileDistributionTest >> test01WhenTryingToCreateATestBoardWithLengthLowerThanThreeThenItRaisesError [

	self
		should: [
			BoardForTesting createWith:
				{ (Tile createWithEffect: NoEffect new) } ]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]

{ #category : 'tests' }
TileDistributionTest >> test02WhenTryingToCreateABoardWithLengthLowerThanThreeThenItRaisesError [

	self
		should: [ Board generateWithTiles: {}]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]

{ #category : 'tests' }
TileDistributionTest >> testBoardBuiltWithBlackHoles [

	| aTestBoard aBuilder blackHoles noEffect |
	aBuilder := TileDistributionBuilder
		            forBoardWithLength: 101 and: 5.
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

	| aTestBoard aBuilder blackHoles atomikBombs noEffect |
	aBuilder := TileDistributionBuilder
		            forBoardWithLength: 101 and: 5.
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

	| aTestBoard aBuilder blackHoles atomikBombs noEffect hyperJump hyperSpaceJump moonWalk wormhole |
	aBuilder := TileDistributionBuilder
		            forBoardWithLength: 101 and: 5.
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
TileDistributionTest >> testWhenWeCreateAWormholeWithEqualEndsThenItRaisesAnError [

	self
		should: [ Wormhole oneEnd: 2 otherEnd: 2 ]
		raiseErrorWithMessageText: 'Wormhole ends must be different tiles.'
]
