"
fasd
"
Class {
	#name : 'TileDistributionBuilder',
	#superclass : 'Object',
	#instVars : [
		'tileList',
		'effectsWithProbabilities',
		'parsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
TileDistributionBuilder class >> forBoardWithLength: aLength and: parsecsPerTile [

	^ self new
		  initializeBuilderForBoardWithLength: aLength
		  and: parsecsPerTile
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

{ #category : 'building' }
TileDistributionBuilder >> buildBoard [
	effectsWithProbabilities do:[:effect | self distributeEffectIntoTileList: effect].
	^ Board generateWithTiles: tileList
]

{ #category : 'listing' }
TileDistributionBuilder >> collectTilesWithNoEffect [

	| tilesWithNoEffect |
	tilesWithNoEffect := OrderedCollection new.
	tileList withIndexDo: [ :tile :index |
		index > 1 ifTrue: [ "NOT COLLECTING FIRST TILE"
			tile hasNoEffect ifTrue: [ tilesWithNoEffect add: index ] ] ].
	^ tilesWithNoEffect
]

{ #category : 'building' }
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
				put: (Tile createWithEffect: anEffectClass create and: parsecs).
			amountNeeded := amountNeeded - 1 ]
]

{ #category : 'initialization' }
TileDistributionBuilder >> initializeBuilderForBoardWithLength: aLength and: parsecsPerTile [

	| oneEnd otherEnd |
	oneEnd := (2 to: aLength) atRandom.
	otherEnd := (2 to: aLength) atRandom.
	[ oneEnd = otherEnd ] whileTrue: [
		otherEnd := (2 to: aLength) atRandom ].
	tileList := (1 to: aLength) collect: [ :x |
		            Tile
			            createWithEffect: NoEffect create
			            and: parsecsPerTile ].
	tileList at: oneEnd put: (Tile
			 createWithEffect: (Wormhole createWith: otherEnd)
			 and: parsecsPerTile).
	tileList at: otherEnd put: (Tile
			 createWithEffect: (Wormhole createWith: oneEnd)
			 and: parsecsPerTile).
	effectsWithProbabilities := OrderedCollection new.
	parsecs := parsecsPerTile
]

{ #category : 'removing' }
TileDistributionBuilder >> removeFromCollectionAtRandom: collection [

	| index |
	index := (Random new next * collection size) ceiling.
	^ collection removeAt: index
]
