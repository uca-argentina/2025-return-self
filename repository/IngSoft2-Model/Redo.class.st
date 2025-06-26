Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Redo >> isRedo [

	^ true
]

{ #category : 'as yet unclassified' }
Redo >> sameTypeOfCard: arg1 [

	^ arg1 isRedo
]
