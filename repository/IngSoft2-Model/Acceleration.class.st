Class {
	#name : 'Acceleration',
	#superclass : 'Card',
	#instVars : [
		'shipId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Acceleration class >> create [

	^ self new initializeWith: 0
]

{ #category : 'as yet unclassified' }
Acceleration >> applyBonusUsing: aThrow [ 
	^ aThrow + 1.
]

{ #category : 'as yet unclassified' }
Acceleration >> equalsCard: aCard [ 
	^ shipId = aCard shipId.
	
]

{ #category : 'initialization' }
Acceleration >> initializeWith: anId [
	shipId := anId.
]

{ #category : 'testing' }
Acceleration >> isAcceleration [ 
^true
]

{ #category : 'as yet unclassified' }
Acceleration >> sameTypeOfCard: aCard [

^aCard isAcceleration 
]

{ #category : 'accessing' }
Acceleration >> shipId [
	^ shipId
]
