Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play interface' }
Redo >> applyBonusUsing: aUselessArgument and: cardManager [

]

{ #category : 'as yet unclassified' }
Redo >> equalsCard: aCard [

	^ aCard isRedo
]

{ #category : 'testing' }
Redo >> isRedo [

	^ true
]
