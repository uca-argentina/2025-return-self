Class {
	#name : 'Repeat',
	#superclass : 'InstantCard',
	#instVars : [
		'chosenShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Repeat class >> createWith: aShip [

	^ self new initializeWith: aShip
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
Repeat >> initializeWith: aShip [

	chosenShip := aShip
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

	context asOrderedCollection size = 1 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	context isShip ifFalse: [
		Error signal: 'Wrong type or order of parameters' ].

	^ self class createWith: context
]
