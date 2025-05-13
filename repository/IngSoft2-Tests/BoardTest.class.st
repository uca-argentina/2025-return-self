Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> testWhenABoardIsAskedForLastTileItReturnsMaxLenght [

	| aBoard aNoEffectObject |
	aNoEffectObject := NoEffect new.
	aBoard := Board withLenght: 20 and: aNoEffectObject.

	self assert: aBoard lenght equals: 20
]
