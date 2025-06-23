Class {
	#name : 'TileDistributionBuilder',
	#superclass : 'Object',
	#instVars : [
		'tileList',
		'effectsWithProbabilities'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
TileDistributionBuilder class >> forBoardWithLength: aLength [
^self new initializeBuilderForBoardWithLength: aLength
]

{ #category : 'adding' }
TileDistributionBuilder >> addEffectToBuilder: anEffectClass [

	effectsWithProbabilities add: anEffectClass
]

{ #category : 'adding' }
TileDistributionBuilder >> addEveryEffectToBuilder [

	effectsWithProbabilities add: AtomikBomb.
	effectsWithProbabilities add: BlackHole.
	effectsWithProbabilities add: HyperJump.
	effectsWithProbabilities add: HyperSpaceJump.
	effectsWithProbabilities add: MoonWalk
	"EffectsWithProbabilities add: anotherEffectClass"
]

{ #category : 'initialization' }
TileDistributionBuilder >> buildBoardWith: amountOfParsecs [ 
	effectsWithProbabilities do:[:effect | self distributeEffectIntoTileList: effect].
	^ Board generateWithTiles: tileList andParsecs: amountOfParsecs
]

{ #category : 'as yet unclassified' }
TileDistributionBuilder >> collectTilesWithNoEffect [

	| tilesWithNoEffect |
	tilesWithNoEffect := OrderedCollection new.
	tileList withIndexDo: [ :tile :index |
		index > 1 ifTrue: [ "NOT COLLECTING FIRST TILE"
			tile effect hasAnEffect ifFalse: [ tilesWithNoEffect add: index ] ] ].
	^ tilesWithNoEffect
]

{ #category : 'initialization' }
TileDistributionBuilder >> distributeEffectIntoTileList: anEffectClass [

	| aProbability tilesWithNoEffect amountNeeded tileIndex |
	aProbability := anEffectClass effectProbability.
	amountNeeded := aProbability * (tileList size - 1). "NOT COUNTING FIRST TILE"
	tilesWithNoEffect := self collectTilesWithNoEffect.

	"LOOPEO HASTA QUE AMOUNT NEEDED SEA CERO O TILESWNOEFFECT SEA CERO, "
	[ amountNeeded > 0 and: [ tilesWithNoEffect isNotEmpty ] ]
		whileTrue: [
			tileIndex := self removeFromCollectionAtRandom: tilesWithNoEffect.
			tileList
				at: tileIndex
				put: (Tile createWithEffect: anEffectClass create).
			amountNeeded := amountNeeded - 1 ]
]

{ #category : 'initialization' }
TileDistributionBuilder >> initializeBuilderForBoardWithLength: aLength [

	tileList := (1 to: aLength) collect: [ :x |
		            Tile createWithEffect: NoEffect create ].
	effectsWithProbabilities := OrderedCollection new
]

{ #category : 'removing' }
TileDistributionBuilder >> removeFromCollectionAtRandom: collection [

	| index |
	index := (Random new next * collection size) ceiling.
	^ collection removeAt: index
]
