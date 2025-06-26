Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#instVars : [
		'chosenShip',
		'caller'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Redo class >> createWith: aShip and: aCaller [

	^ self new initializeWith: aShip and: aCaller
]

{ #category : 'play interface' }
Redo >> applyBonusUsing: cardManager [

	| context lastCard |
	context := {
		           chosenShip.
		           caller }.
	context := cardManager trimContextConsultingManual: context.
	lastCard := cardManager lastPlayedCard.

	lastCard := lastCard setupWith: context.

	cardManager storeLastCardPlayed: lastCard class.

	lastCard isPermanentCard ifTrue: [
		cardManager addToPermanentCards: lastCard ].

	lastCard isInstantCard ifTrue: [
		lastCard applyBonusUsing: cardManager ]
]

{ #category : 'accessing' }
Redo >> chosenShip [

	^ chosenShip
]

{ #category : 'comparing' }
Redo >> equalsACard: aCard [

	aCard isRedo ifTrue: [ ^ chosenShip = aCard chosenShip ].
	^ false
]

{ #category : 'initialization' }
Redo >> initializeWith: aShip and: aCaller [

	chosenShip := aShip.
	caller := aCaller
]

{ #category : 'testing' }
Redo >> isRedo [

	^ true
]

{ #category : 'comparing' }
Redo >> sameTypeOfCard: aCard [

	^ aCard isRedo
]

{ #category : 'setup' }
Redo >> setupWith: context [

	context asOrderedCollection size = 2 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	(context at: 1) isShip ifFalse: [
		Error signal: 'Wrong type or order of parameters' ].
	(context at: 2) isShip ifFalse: [
		Error signal: 'Wrong type or order of parameters' ].
	^ self class createWith: (context at: 1) and: (context at: 2)
]
