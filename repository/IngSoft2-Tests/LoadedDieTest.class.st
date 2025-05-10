Class {
	#name : 'LoadedDieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LoadedDieTest >> testWhenThrowingLoadedDieThenReturnsGivenNumber [

| aLoadedDie |
aLoadedDie := LoadedDie rolling: 4.

self assert: aLoadedDie throw equals: 4.
]
