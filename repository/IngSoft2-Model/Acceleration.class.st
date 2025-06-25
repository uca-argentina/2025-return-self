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
	^ self new initializeWith: 0.
]

{ #category : 'as yet unclassified' }
Acceleration class >> createWithAnId: anId [ 
	^self new initializeWith: anId 
]

{ #category : 'as yet unclassified' }
Acceleration >> applyBounsUsing: aThrow [ 
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

{ #category : 'accessing' }
Acceleration >> shipId [
	^ shipId
]
