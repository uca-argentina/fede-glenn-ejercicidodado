Class {
	#name : #ProbabilityDistributorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityDistributorTest >> testGetDistributedArrayOfObjects [
	| result distributor |
	distributor := ProbabilityDistributor new
		createShuffledCollection:
			{(ProbabilityWrapper with: 'Fede' probability: 0.4).
			(ProbabilityWrapper with: 'Abril' probability: 0.6)}
		size: 100.
	self
		assert: (distributor count: [ :name | 'Fede' == name ])
		equals: 40.
	self
		assert: (distributor count: [ :name | 'Abril' == name ])
		equals: 60
]

{ #category : #tests }
ProbabilityDistributorTest >> testGetDistributedArrayOfObjectsPadded [
	| result distributor |
	distributor := ProbabilityDistributor new
		createShuffledCollection:
			{(ProbabilityWrapper with: 'Fede' probability: 0.4).
			(ProbabilityWrapper with: 'Abril' probability: 0.4)}
		defaultElement: ''
		size: 100.
	self assert: distributor size equals: 100.
	self
		assert: (distributor count: [ :name | 'Fede' == name ])
		equals: 40.
	self
		assert: (distributor count: [ :name | 'Abril' == name ])
		equals: 40.
	self
		assert: (distributor count: [ :name | '' == name ])
		equals: 20
]
