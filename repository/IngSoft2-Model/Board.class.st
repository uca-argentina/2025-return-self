Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles',
		'allEffects'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> createWithTiles: aNumberOfTiles [ 
	^ self new initializeWithTiles: aNumberOfTiles
]

{ #category : 'as yet unclassified' }
Board class >> createWithTiles: totalTiles andEffects: aCollectionOfEffects [ 
	^self new initializeWithTiles: totalTiles andEffects: aCollectionOfEffects 
]

{ #category : 'positioning' }
Board >> applyEffectOn: aSetOfPlayers onIndex: anIndex [ 
	| detectedEffect |
	detectedEffect := tiles detect: [ :effect | effect tiles = ((aSetOfPlayers at: anIndex) position) ].
	^detectedEffect applyEffectOn: aSetOfPlayers onIndex: anIndex 
]

{ #category : 'initialization' }
Board >> initializeWithTiles: aNumberOfTiles [ 

    | rng cumulativeProbs effectClasses|
    rng := Random new.                   
    effectClasses := { AtomikBomb. BlackHole. HyperJump. HyperSpaceJump. MoonWalk. NoEffect }.

    cumulativeProbs := Array new: effectClasses size.
    effectClasses
        withIndexDo: [ :cls :i | | acum |
            acum := (i = 1
                      ifTrue: [ 0 ]
                      ifFalse: [ cumulativeProbs at: i - 1 ]) + cls effectProbability.
            cumulativeProbs at: i put: acum ].
    
    "2. Para cada casilla, sortear un efecto con peso:"
    tiles := (1 to: aNumberOfTiles) collect: [ :idx |
        | r chosenClass |
        r := rng next.                         "Número real [0,1)"
        chosenClass := effectClasses
            detect: [ :cls | r <= (cumulativeProbs at: (effectClasses indexOf: cls)) ]
            ifNone: [ effectClasses last ].    "por redondeo"
        chosenClass initializeOnTile: idx                       "instancia de efecto"
    ].


]

{ #category : 'accessing' }
Board >> totalTiles [
	^ tiles size.
]
