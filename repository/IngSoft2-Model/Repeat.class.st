Class {
	#name : 'Repeat',
	#superclass : 'InstantCard',
	#instVars : [
		'chosenShip',
		'gameRef'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Repeat class >> createWith: aShip and: aGameReference [

	^ self new initializeWith: aShip and: aGameReference
]

{ #category : 'play interface' }
Repeat >> applyBonusUsing: cardManager [

	|lastEffect|
	lastEffect := cardManager lastEffectApplied.
	
	lastEffect applyEffectOn: chosenShip and: gameRef
]

{ #category : 'accessing' }
Repeat >> chosenShip [

	^ chosenShip
]

{ #category : 'comparing' }
Repeat >> equalsACard: aCard [

	aCard isRepeat ifTrue: [ ^ chosenShip = aCard chosenShip ].
	^ false
]

{ #category : 'initialization' }
Repeat >> initializeWith: aShip and: aGameReference [

	chosenShip := aShip.
	gameRef := aGameReference
]

{ #category : 'testing' }
Repeat >> isRepeat [

	^ true
]

{ #category : 'as yet unclassified' }
Repeat >> replicateEffect: arg1 targeting: arg2 using: arg3 [

	arg1 applyEffectOn: arg2 and: arg3
]

{ #category : 'comparing' }
Repeat >> sameTypeOfCard: aCard [

	^ aCard isRepeat
]

{ #category : 'setup' }
Repeat >> setupWith: context [

	context asOrderedCollection size = 2 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	(context at: 1) isShip ifFalse: [
		Error signal: 'Wrong type or order of parameters' ].
	(context at: 2) isGame ifFalse: [
		Error signal: 'Wrong type or order of parameters' ].

	^ self class createWith: (context at: 1) and: (context at: 2)
]
