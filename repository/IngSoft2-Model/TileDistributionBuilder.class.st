"
fasd
"
Class {
	#name : 'TileDistributionBuilder',
	#superclass : 'Object',
	#instVars : [
		'tileList',
		'effectsWithProbabilities',
		'tileLength',
		'freeTiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
TileDistributionBuilder class >> createTileListWith: aLength [

	^ self createTileListWith: aLength and: Tile defaultLength
]

{ #category : 'creation' }
TileDistributionBuilder class >> createTileListWith: aLength and: aTileLength [

	Board boardLengthMustBeGreaterThanThree: aLength.
	^ self new initializeBuilderForBoardWithLength: aLength and: aTileLength
]

{ #category : 'creation' }
TileDistributionBuilder class >> createTileListWith: aLength withTotalLength: aDistance [

	^ self
		createTileListWith: aLength
		and: (Parsecs of: aDistance asParsecs / aLength)
]

{ #category : 'adding' }
TileDistributionBuilder >> addEffectToBuilder: anEffectClass [

	effectsWithProbabilities add: anEffectClass
]

{ #category : 'adding' }
TileDistributionBuilder >> addEveryEffectToBuilder [

	effectsWithProbabilities add: AtomikBomb.
	effectsWithProbabilities add: BlackHole.
	effectsWithProbabilities add: CardGiver.
	effectsWithProbabilities add: HyperJump.
	effectsWithProbabilities add: HyperSpaceJump.
	effectsWithProbabilities add: MoonWalk
]

{ #category : 'building' }
TileDistributionBuilder >> buildBoard [

	effectsWithProbabilities do: [ :effect |
		self distributeEffectIntoTileList: effect ].
	^ Board createWith: tileList
]

{ #category : 'building' }
TileDistributionBuilder >> distributeEffectIntoTileList: anEffectClass [

	| amountNeeded tileIndex |
	amountNeeded := (anEffectClass effectProbability * (tileList size - 1)) rounded.
	[ amountNeeded > 0 and: [ freeTiles isNotEmpty ] ] whileTrue: [
		tileIndex := self removeFromCollectionAtRandom: freeTiles.
		tileList
			at: tileIndex
			put: (Tile createWithEffect: anEffectClass create and: tileLength).
		amountNeeded := amountNeeded - 1 ]
]

{ #category : 'initialization' }
TileDistributionBuilder >> initializeBuilderForBoardWithLength: aLength and: aTileLength [

	| oneEnd otherEnd |
	oneEnd := (2 to: aLength) atRandom.
	otherEnd := (2 to: aLength) atRandom.
	[ oneEnd = otherEnd ] whileTrue: [
		otherEnd := (2 to: aLength) atRandom ].
	tileList := (1 to: aLength) collect: [ :x |
		Tile createWithEffect: NoEffect create and: aTileLength ].
	tileList at: oneEnd put: (Tile
			createWithEffect: (Wormhole createWith: otherEnd)
			and: aTileLength).
	tileList at: otherEnd put: (Tile
			createWithEffect: (Wormhole createWith: oneEnd)
			and: aTileLength).
	freeTiles := (2 to: aLength) asOrderedCollection.
	freeTiles remove: oneEnd.
	freeTiles remove: otherEnd.
	effectsWithProbabilities := OrderedCollection new.
	tileLength := aTileLength
]

{ #category : 'removing' }
TileDistributionBuilder >> removeFromCollectionAtRandom: collection [

	| chosenElement |
	chosenElement := collection atRandom.
	collection remove: chosenElement.
	^ chosenElement
]
