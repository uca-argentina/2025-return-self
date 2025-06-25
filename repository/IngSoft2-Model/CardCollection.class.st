Class {
	#name : 'CardCollection',
	#superclass : 'Object',
	#instVars : [
		'cards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardCollection class >> create [

	^ self new initializeCardsWith: OrderedCollection new
]

{ #category : 'creation' }
CardCollection class >> createWith: aListOfCards [

	^ self new initializeCardsWith: aListOfCards asOrderedCollection
]

{ #category : 'adding' }
CardCollection >> add: aCard [

cards add: aCard
]

{ #category : 'accessing' }
CardCollection >> at: index [
^cards at:index
]

{ #category : 'initialization' }
CardCollection >> initializeCardsWith: aCardCollection [

	cards := aCardCollection
]
