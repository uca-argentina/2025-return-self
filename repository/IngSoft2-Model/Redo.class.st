Class {
	#name : 'Redo',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Redo >> isRedo [

^true
]

{ #category : 'as yet unclassified' }
Redo >> sameTypeOfCard: aCard [
^ aCard isRedo
]
