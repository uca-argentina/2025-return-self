Class {
	#name : 'Repeat',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Repeat >> isRepeat [

	^ true
]

{ #category : 'as yet unclassified' }
Repeat >> replicateEffect: arg1 targeting: arg2 using: arg3 [

	arg1 applyEffectOn: arg2 and: arg3
]

{ #category : 'as yet unclassified' }
Repeat >> sameTypeOfCard: aCard [

	^ aCard isRepeat
]
