Class {
	#name : 'ReversePolarity',
	#superclass : 'PermanentCard',
	#instVars : [
		'tile'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
ReversePolarity class >> createWith: aTileNumber [

	^ self new initializeWith: aTileNumber
]

{ #category : 'polarity' }
ReversePolarity >> effect: anEffect atTile: aTileNumber [

	^ (self reverses: aTileNumber)
		ifTrue: [ EffectWithReversedPolarity of: anEffect ]
		ifFalse: [ anEffect ]
]

{ #category : 'comparing' }
ReversePolarity >> equalsACard: aCard [

	^ (self sameTypeOfCard: aCard) and: [ aCard reverses: tile ]
]

{ #category : 'initialization' }
ReversePolarity >> initializeWith: aTileNumber [

	tile := aTileNumber
]

{ #category : 'playing' }
ReversePolarity >> playedBy: aShip in: aGame [

	self assertHasTarget: tile.
	aGame assertIsOnTheBoard: tile.
	^ super playedBy: aShip in: aGame
]

{ #category : 'testing' }
ReversePolarity >> reverses: aTileNumber [

	^ tile = aTileNumber
]

{ #category : 'setup' }
ReversePolarity >> setupWith: aTarget [

	^ self class createWith: aTarget
]
