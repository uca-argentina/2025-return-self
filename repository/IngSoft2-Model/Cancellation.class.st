Class {
	#name : 'Cancellation',
	#superclass : 'InstantCard',
	#instVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Cancellation class >> createWith: idToCancel [

	self idCantBeNegative: idToCancel.
	^ self new initializeWith: idToCancel
]

{ #category : 'as yet unclassified' }
Cancellation class >> idCantBeNegative: anId [

anId < 0 ifTrue: [ Error signal: 'There is no matching active card to cancel.' ]
]

{ #category : 'play interface' }
Cancellation >> applyBonusUsing: aCard and: cardManager [

	cardManager searchAndCancel: aCard
]

{ #category : 'as yet unclassified' }
Cancellation >> cancelPlayingCard: arg1 using: arg2 [

"	| tmp1 |
	tmp1 := arg2 detect: [ :arg3 | arg3 equalsCard: arg1 ].
	arg2 remove: tmp1"
]

{ #category : 'initialization' }
Cancellation >> initializeWith: context [

	cardId := context
]

{ #category : 'testing' }
Cancellation >> isCancellation [

	^ true
]

{ #category : 'as yet unclassified' }
Cancellation >> sameTypeOfCard: aCard [

	^ aCard isCancellation
]

{ #category : 'as yet unclassified' }
Cancellation >> setupWith: context [

	context asOrderedCollection size = 1 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	^ self class createWith: context
]
