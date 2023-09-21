Class {
	#name : 'DTTestMutationPlugin',
	#superclass : 'DrTestsPlugin',
	#instVars : [
		'testsCases',
		'classesToMutate',
		'firstListLabel',
		'firstListItems',
		'secondListLabel',
		'secondListItems'
	],
	#category : 'DrTests-TestMutation-Base',
	#package : 'DrTests-TestMutation',
	#tag : 'Base'
}

{ #category : 'api - accessing' }
DTTestMutationPlugin class >> pluginName [

	^ 'Test Mutation'
]

{ #category : 'api - accessing' }
DTTestMutationPlugin class >> pluginResultClass [

	^ DTTestMutationResult
]

{ #category : 'api - accessing' }
DTTestMutationPlugin class >> weight [

	^ 3
]

{ #category : 'as yet unclassified' }
DTTestMutationPlugin >> buildSelectionWithTestCasesAndClasses [

	<dtTestsMutationSelection: 'Selection with Test Cases and Classes' order: 2>
	 
	| package |
	"Get only test cases"
	firstListLabel := 'Test Cases'.
	package := self packageOrganizer packages select: [ :p |
		           p definedClasses anySatisfy: [ :c | c isTestCase ] ].
	firstListItems := package flatCollect: [ :p |
		                  p definedClasses select: [ :c | c isTestCase ] ].

	"Get only classes"
	secondListLabel := 'Classes'.
	package := self packageOrganizer packages select: [ :p |
		           p definedClasses anySatisfy: [ :c | c isTestCase not ] ].
	secondListItems := package flatCollect: [ :p |
		                   p definedClasses select: [ :c | c isTestCase not ] ]
]

{ #category : 'as yet unclassified' }
DTTestMutationPlugin >> buildSelectionWithTestPackageAndClasses [
	<dtTestsMutationSelection: 'Selection with Test Packages and Classes' order: 1>

	| package |
	"Get test packages"
	firstListLabel := 'Test Packages'.
	package := self packageOrganizer packages select: [ :p |
		           p definedClasses anySatisfy: [ :c | c isTestCase ] ].
	firstListItems := package.

	"Get only classes"
	secondListLabel := 'Classes'.
	package := self packageOrganizer packages select: [ :p |
		           p definedClasses anySatisfy: [ :c | c isTestCase not ] ].
	secondListItems := package flatCollect: [ :p |
		                   p definedClasses select: [ :c | c isTestCase not ] ]
]

{ #category : 'as yet unclassified' }
DTTestMutationPlugin >> buildSelectionWithTestPackagesAndClassPackages [
	<dtTestsMutationSelection: 'Selection with Test Packages and Class Packages' order: 3>

	| package |
	"Get only test cases"
	firstListLabel := 'Test Packages'.
	package := self packageOrganizer packages select: [ :p |
		           p definedClasses anySatisfy: [ :c | c isTestCase ] ].
	firstListItems := package.

	"Get only classes"
	secondListLabel := 'Class Packages'.
	package := self packageOrganizer packages select: [ :p |
		           p definedClasses anySatisfy: [ :c | c isTestCase not ] ].
	secondListItems := package.
]

{ #category : 'api' }
DTTestMutationPlugin >> defineData: aDTpluginConfiguration [

	| firstList secondList |
	firstList := aDTpluginConfiguration packagesSelected.
	secondList := aDTpluginConfiguration items.
	
	"ask geraldine"
	testsCases := firstList.
	(firstList anyOne isKindOf: RPackage)
		ifTrue: [ testsCases := firstList flatCollect: [ :p |
				              p definedClasses select: [ :c | c isTestCase ] ] ].
		
	(secondList anyOne isKindOf: RPackage)
		ifTrue: [ classesToMutate := secondList flatCollect: [ :p |
				                   p definedClasses select: [ :c | c isTestCase not] ] ]
		ifFalse: [ classesToMutate := secondList ]
]

{ #category : 'accessing' }
DTTestMutationPlugin >> firstListLabel [

	firstListLabel ifNil: [ ^ 'is Nil' ].
	^ firstListLabel
]

{ #category : 'api' }
DTTestMutationPlugin >> itemsToBeAnalysedFor: packagesSelected [

	^ secondListItems
]

{ #category : 'api' }
DTTestMutationPlugin >> packagesAvailableForAnalysis [
	"by default it will display the testpackages with classes"

	firstListItems ifNotNil: [ ^ firstListItems ].
	self buildSelectionWithTestPackageAndClasses.
	^ firstListItems
]

{ #category : 'ui' }
DTTestMutationPlugin >> pluginPresenterClass [

	^ DTMutationPluginPresenter 
]

{ #category : 'accessing' }
DTTestMutationPlugin >> pragmaForResultTrees [
	^ #'dtTestMutationResultTreeNamed:order:'
]

{ #category : 'api' }
DTTestMutationPlugin >> pragmaForSelectionPackagesAndItems [

	^ #dtTestsMutationSelection:order:
]

{ #category : 'api' }
DTTestMutationPlugin >> resultButtonHelp [
	^ 'Browse the mutation selected in the results list.' translated
]

{ #category : 'api' }
DTTestMutationPlugin >> runForConfiguration: aDTpluginConfiguration [

	| result analysis alive killed percent analysisResult|
	result := self pluginResultClass new.
	self defineData: aDTpluginConfiguration.

	analysis := MutationTestingAnalysis
		            testCasesFrom: testsCases
		            mutating: classesToMutate
		            using: MutantOperator contents
		            with: AllTestsMethodsRunningMutantEvaluationStrategy new.
	analysis run.
	analysisResult := analysis generalResult .
	alive := analysisResult aliveMutants "collect: [:each | each asString ]. " .
	killed := analysisResult killedMutants "collect: [:each | each asString ]. " .
	percent := analysisResult numberOfEvaluatedMutants printString , ' mutants, '
	           , analysisResult numberOfKilledMutants printString , ' killed, '
	           , analysisResult numberOfAliveMutants printString , ' alive, '
	           , analysisResult numberOfTerminatedMutants printString
	           , ' terminated. Mutation Score: '
	           , analysisResult mutationScore printString , '%.'.

	^ result
		  aliveMutants: alive;
		  killedMutants: killed;
		  percentageResult: percent;
		  mutationScore: analysisResult mutationScore printString , '%.' .
]

{ #category : 'accessing' }
DTTestMutationPlugin >> secondListLabel [

	secondListLabel ifNil: [ ^ 'is Nil' ].
	^ secondListLabel 
]

{ #category : 'as yet unclassified' }
DTTestMutationPlugin >> selectionOptionViews [
	"Return the selction options available."

	| pragmas resultClass pluginClass symbol |
	resultClass := self pluginResultClass.
	pluginClass := self class.
	symbol := self pragmaForSelectionPackagesAndItems.
	pragmas := Pragma
		           allNamed: self pragmaForSelectionPackagesAndItems
		           in: self class.
	^ (pragmas sorted: [ :p | p argumentAt: 2 ] asSortFunction) collect: [
		  :pragma |
		  DTResultTreeView
			  name: (pragma argumentAt: 1)
			  blockToExtractViewFromResult: pragma methodSelector]
]

{ #category : 'api' }
DTTestMutationPlugin >> startButtonHelp [
	^ 'Run mutation in selected items' translated
]

{ #category : 'api' }
DTTestMutationPlugin >> startButtonLabel [
	^ 'Run Mutation' translated
]
