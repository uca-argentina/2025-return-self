Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play interface' }
Redo >> applyBonusUsing: aUselessArgument and: cardManager [

]

{ #category : 'testing' }
Redo >> isRedo [

	^ true
]

{ #category : 'as yet unclassified' }
Redo >> sameTypeOfCard: aCard [

	^ aCard isRedo
]
