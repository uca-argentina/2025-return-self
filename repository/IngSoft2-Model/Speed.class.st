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

{ #category : 'as yet unclassified' }
Speed >> applyBonusUsing: data [
"
	^ aTotalThrow + 1"
	self shouldBeImplemented 
]

{ #category : 'accessing' }
Speed >> chosenShip [

	^ chosenShip
]

{ #category : 'as yet unclassified' }
Speed >> equalsACard: aCard [

	aCard isSpeed ifTrue: [ ^ chosenShip = aCard chosenShip ].
	^ false
]

{ #category : 'initialization' }
Speed >> initializeWith: aChosenShip [

	chosenShip := aChosenShip
]

{ #category : 'testing' }
Speed >> isSpeed [

	^ true
]

{ #category : 'as yet unclassified' }
Speed >> sameTypeOfCard: aCard [

	^ aCard isSpeed
]

{ #category : 'as yet unclassified' }
Speed >> setupWith: context [

	context asOrderedCollection size = 1 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	context isShip ifFalse: [
		Error signal: 'Wrong type or order of parameters' ].
	^ self class createWith: context
]
