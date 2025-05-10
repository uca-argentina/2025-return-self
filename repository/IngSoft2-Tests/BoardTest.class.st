Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> testWhenABoardIsAskedForLastTileItReturnsMaxLenght [

| aBoard |
aBoard:=Board withLenght: 20.

self assert: aBoard lenght equals: 20.
]
