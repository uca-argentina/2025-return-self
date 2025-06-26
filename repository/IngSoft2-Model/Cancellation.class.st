Class {
	#name : 'Cancellation',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

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

{ #category : 'testing' }
Cancellation >> isCancellation [

	^ true
]

{ #category : 'as yet unclassified' }
Cancellation >> sameTypeOfCard: aCard [

	^ aCard isCancellation
]
