Class {
	#name : 'Reverse',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
Reverse >> applyIn: aGame [

	aGame reverseTurnOrder
]
