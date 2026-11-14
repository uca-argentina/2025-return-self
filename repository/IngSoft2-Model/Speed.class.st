Class {
	#name : 'Speed',
	#superclass : 'PermanentCard',
	#instVars : [
		'chosenShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Speed class >> createWith: aChosenShip [

	^ self new initializeWith: aChosenShip
]

{ #category : 'bonus' }
Speed >> boost: aThrow of: aShip [

	^ (self boosts: aShip)
		ifTrue: [ aThrow + 1 ]
		ifFalse: [ aThrow ]
]

{ #category : 'testing' }
Speed >> boosts: aShip [

	^ chosenShip equalsID: aShip
]

{ #category : 'initialization' }
Speed >> initializeWith: aChosenShip [

	chosenShip := aChosenShip
]

{ #category : 'playing' }
Speed >> playedBy: aShip in: aGame [

	self assertHasTarget: chosenShip.
	aGame assertIsPlaying: chosenShip.
	^ super playedBy: aShip in: aGame
]

{ #category : 'setup' }
Speed >> setupWith: aTarget [

	^ self class createWith: aTarget
]
