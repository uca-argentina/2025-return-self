Class {
	#name : 'TileDistributionBuilder',
	#superclass : 'Object',
	#instVars : [
		'tileList',
		'parsecs',
		'EffectsWithProbabilities'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
TileDistributionBuilder class >> forBoardWithLength: aLength [
^self new initializeBuilderForBoardWithLength: aLength 
]

{ #category : 'as yet unclassified' }
TileDistributionBuilder class >> forBoardWithLength: aLength andParsecs: someParsecs [
^self new initializeBuilderForBoardWithLength: aLength andParsecs: someParsecs 
]

{ #category : 'adding' }
TileDistributionBuilder >> addEffect: anEffect withProbability: aProbability [

	| tilesWithNoEffect amountNeeded tileIndex |
	amountNeeded := aProbability * (tileList size - 1). "NOT COUNTING FIRST TILE"
	tilesWithNoEffect := self collectTilesWithNoEffect.

	"LOOPEO HASTA QUE AMOUNT NEEDED SEA CERO O TILESWNOEFFECT SEA CERO, "
	[ amountNeeded > 0 and: [ tilesWithNoEffect isNotEmpty ] ]
		whileTrue: [
			tileIndex := self removeFromCollectionAtRandom: tilesWithNoEffect.
			tileList at: tileIndex put: (Tile createWithEffect: anEffect).
			amountNeeded := amountNeeded - 1 ]
]

{ #category : 'adding' }
TileDistributionBuilder >> addEffectToBuilder: anEffectClass [

	EffectsWithProbabilities add: anEffectClass
]

{ #category : 'adding' }
TileDistributionBuilder >> addEveryEffectToBuilder [

	EffectsWithProbabilities add: AtomikBomb.
	EffectsWithProbabilities add: BlackHole.
	EffectsWithProbabilities add: HyperJump.
	EffectsWithProbabilities add: HyperSpaceJump.
	EffectsWithProbabilities add: MoonWalk
	"EffectsWithProbabilities add: anotherEffectClass"
]

{ #category : 'initialization' }
TileDistributionBuilder >> buildBoard [

	^ Board generateWithTiles: tileList andParsecs: parsecs
]

{ #category : 'initialization' }
TileDistributionBuilder >> buildEffectIntoTileList: anEffect withProbability: aProbability [

	| tilesWithNoEffect amountNeeded tileIndex |
	amountNeeded := aProbability * (tileList size - 1). "NOT COUNTING FIRST TILE"
	tilesWithNoEffect := self collectTilesWithNoEffect.

	"LOOPEO HASTA QUE AMOUNT NEEDED SEA CERO O TILESWNOEFFECT SEA CERO, "
	[ amountNeeded > 0 and: [ tilesWithNoEffect isNotEmpty ] ]
		whileTrue: [
			tileIndex := self removeFromCollectionAtRandom: tilesWithNoEffect.
			tileList at: tileIndex put: (Tile createWithEffect: anEffect).
			amountNeeded := amountNeeded - 1 ]
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
TileDistributionBuilder >> initializeBuilderForBoardWithLength: aLength andParsecs: anAmountOfParsecs [

	tileList := (1 to: aLength) collect: [ :x |
		            Tile createWithEffect: NoEffect new ].
	parsecs := anAmountOfParsecs.
	EffectsWithProbabilities := OrderedCollection new
]

{ #category : 'removing' }
TileDistributionBuilder >> removeFromCollectionAtRandom: collection [

	| index |
	index := (Random new next * collection size) ceiling.
	^ collection removeAt: index
]
