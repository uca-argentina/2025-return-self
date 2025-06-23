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
TileDistributionTest >> testBoardBuiltWithBlackHoles [

	| aTestBoard aBuilder blackHoles noEffect |
	aBuilder := TileDistributionBuilder
		            forBoardWithLength: 101
		            andParsecs: 1000.
	aBuilder addEffectToBuilder: BlackHole.
	aTestBoard := aBuilder buildBoard.

	blackHoles := 0.
	noEffect := 0.
	aTestBoard tiles do: [ :tile |
		(tile effect isOf: 'BlackHole') ifTrue: [
			blackHoles := blackHoles + 1 ].
		(tile effect isOf: 'NoEffect') ifTrue: [ noEffect := noEffect + 1 ] ].

	self assert: blackHoles equals: 20.
	self assert: noEffect equals: 81.
]

{ #category : 'tests' }
TileDistributionTest >> testBoardBuiltWithBlackHolesAndAtomikBomb [

	| aTestBoard aBuilder blackHoles atomikBombs noEffect |
	aBuilder := TileDistributionBuilder
		            forBoardWithLength: 101
		            andParsecs: 1000.
	aBuilder addEffectToBuilder: BlackHole.
	aBuilder addEffectToBuilder: AtomikBomb.
	aTestBoard := aBuilder buildBoard.

	blackHoles := 0.
	atomikBombs := 0.
	noEffect := 0.
	aTestBoard tiles do: [ :tile |
		(tile effect isOf: 'BlackHole') ifTrue: [
			blackHoles := blackHoles + 1 ].
		(tile effect isOf: 'NoEffect') ifTrue: [ noEffect := noEffect + 1 ].
		(tile effect isOf: 'AtomikBomb') ifTrue: [
			atomikBombs := atomikBombs + 1 ] ].


	self assert: blackHoles equals: 20.
	self assert: atomikBombs equals: 2.
	self assert: noEffect equals: 79
]

{ #category : 'tests' }
TileDistributionTest >> testBoardWithEveryThing [

	| aTestBoard aBuilder blackHoles atomikBombs noEffect hyperJump hyperSpaceJump moonWalk |
	aBuilder := TileDistributionBuilder
		            forBoardWithLength: 101
		            andParsecs: 1000.
	aBuilder addEveryEffectToBuilder .
	aTestBoard := aBuilder buildBoard.

	blackHoles := 0.
	atomikBombs := 0.
	hyperJump := 0.
	hyperSpaceJump := 0.
	moonWalk := 0.
	noEffect := 0.
	aTestBoard tiles do: [ :tile |
		(tile effect isOf: 'BlackHole') ifTrue: [
			blackHoles := blackHoles + 1 ].
		(tile effect isOf: 'NoEffect') ifTrue: [ noEffect := noEffect + 1 ].
		(tile effect isOf: 'HyperJump') ifTrue: [ hyperJump := hyperJump + 1 ].
		(tile effect isOf: 'HyperSpaceJump') ifTrue: [ hyperSpaceJump := hyperSpaceJump + 1 ].
		(tile effect isOf: 'MoonWalk') ifTrue: [ moonWalk := moonWalk + 1 ].
		(tile effect isOf: 'AtomikBomb') ifTrue: [
			atomikBombs := atomikBombs + 1 ] ].


	self assert: blackHoles equals: 20.
	self assert: atomikBombs equals: 2.
	self assert: noEffect equals: 41.
	self assert: hyperJump equals: 8.
	self assert: hyperSpaceJump equals: 20.
	self assert: moonWalk equals: 10
]
