Class {
	#name : 'Repeat',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Repeat >> isRepeat [

^true
]

{ #category : 'as yet unclassified' }
Repeat >> replicateEffect: aBlackHole targeting: aPlayer  using: aGame [
	aBlackHole applyEffectOn: aPlayer and: aGame.
]

{ #category : 'as yet unclassified' }
Repeat >> sameTypeOfCard: aCard [
^aCard isRepeat 
]
