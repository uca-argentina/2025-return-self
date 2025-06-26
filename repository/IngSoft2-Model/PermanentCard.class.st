Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#instVars : [
		'shipId'
	],
	#category : 'IngSoft2-Model-Objects',
	#package : 'IngSoft2-Model',
	#tag : 'Objects'
}

{ #category : 'testing' }
PermanentCard class >> isPermanentCard [

^true
]

{ #category : 'as yet unclassified' }
PermanentCard >> applyBonusUsing: anArgument [

	self subclassResponsibility
]

{ #category : 'testing' }
PermanentCard >> isPermanentCard [
	^ self class isPermanentCard
]

{ #category : 'comparing' }
PermanentCard >> sameTypeOfCard: aCard [

	self subclassResponsibility
]

{ #category : 'accessing' }
PermanentCard >> shipId [

	^ shipId 
]
