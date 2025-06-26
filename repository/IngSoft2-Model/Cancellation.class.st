Class {
	#name : 'Cancellation',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Cancellation >> cancelPlayingCard: aCard using: aCollectionOfCards [
	
	| cardToRemove |
	cardToRemove := aCollectionOfCards detect: [ :card | card equalsCard: aCard ].
	aCollectionOfCards remove: cardToRemove.
]

{ #category : 'as yet unclassified' }
Cancellation >> equalsACard: aCard [

	^ aCard isCancellation
]

{ #category : 'testing' }
Cancellation >> isCancellation [ 
^true
]
