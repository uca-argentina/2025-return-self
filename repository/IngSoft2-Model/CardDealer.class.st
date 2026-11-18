Class {
	#name : 'CardDealer',
	#superclass : 'Object',
	#instVars : [
		'cardKinds'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardDealer class >> dealing: aCollectionOfCardKinds [

	self mustDealAtLeastOneKindOfCard: aCollectionOfCardKinds.
	^ self new initializeDealing: aCollectionOfCardKinds
]

{ #category : 'testing' }
CardDealer class >> mustDealAtLeastOneKindOfCard: aCollectionOfCardKinds [

	aCollectionOfCardKinds isEmpty ifTrue: [
		Error signal: 'A card dealer needs at least one kind of card to deal.' ]
]

{ #category : 'creation' }
CardDealer class >> withEveryCard [

	^ self dealing: {
			Acceleration.
			Cancellation.
			Double.
			Mercenary.
			Redo.
			Repeat.
			Reverse.
			ReversePolarity.
			Skip.
			Speed }
]

{ #category : 'dealing' }
CardDealer >> dealCard [

	^ cardKinds atRandom create
]

{ #category : 'initialization' }
CardDealer >> initializeDealing: aCollectionOfCardKinds [

	cardKinds := aCollectionOfCardKinds
]
