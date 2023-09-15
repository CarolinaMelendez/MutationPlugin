Class {
	#name : #DTMutationPluginPresenter,
	#superclass : #DTDefaultPluginPresenter,
	#instVars : [
		'selectionViewsDropList',
		'diffPresenter'
	],
	#category : #'DrTests-TestMutation-Spec'
}

{ #category : #initialization }
DTMutationPluginPresenter >> connectPresenters [

	super connectPresenters.
	
	self  selectionViewsDropList 
		whenSelectedItemChangedDo: [ :selectionOptionViewOrNil |
			selectionOptionViewOrNil
				ifNotNil: [ |var | . var := self . 
					selectionOptionViewOrNil updateSelectionOption: drTests currentPlugin.
					"selectionOptionViewOrNil updateListsDesign: self."
					self updatePackagesListAndItems .
					"  . "] ] .
	
	"resultsList whenSelectionChangedDo: [ :selection | 
		(selection selectedItem isKindOf: DTTestMutationLeafNode) ifTrue: [
			selection selectedItem ifNotNil: [ :item |
				self updateDiffPresenter: item content ] ] ]"
]

{ #category : #layout }
DTMutationPluginPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpPanedLayout newLeftToRight
					add: (SpBoxLayout newTopToBottom
						    spacing: 5;
						    add: selectionViewsDropList expand: false;
						    add: (SpPanedLayout newLeftToRight
						    		  add: packagesList;
						    		  add: itemsList;
						    		  yourself);
						    yourself);
				   "add: (SpPanedLayout newLeftToRight
						    add: packagesList;
						    add: itemsList;
						    yourself);"
				   add: (SpBoxLayout newTopToBottom
						    spacing: 5;
						    add: resultViewsDropList expand: false;
						    add: resultLabel expand: false;
						    add: resultsList;
						    add: diffPresenter;
						    yourself);
				   yourself);
		  add: startButton expand: false;
		  yourself
]

{ #category : #initialization }
DTMutationPluginPresenter >> initializePresenters [

	super initializePresenters.

	self
		initializePackagesListAndLabel;
		initializeItemsListAndLabel;
		initializeResultsTreeAndLabel;
		initializeResultViewsDropList;
		initializeSelectionViewsDropList.

	startButton := self newButton.
	startButton action: [ drTests runPlugin ].
	
	diffPresenter := self newDiff.
	diffPresenter showOptions: false .
]

{ #category : #initialization }
DTMutationPluginPresenter >> initializeSelectionViewsDropList [

	selectionViewsDropList := self newDropList.
	self selectionViewsDropList
		help: 'Select the different views to select';
		display: [ :resultTreeView | resultTreeView name ]
]

{ #category : #accessing }
DTMutationPluginPresenter >> selectionViewsDropList [

	^ selectionViewsDropList
]

{ #category : #'as yet unclassified' }
DTMutationPluginPresenter >> updatePackagesListAndItems [

	self updatePackagesList.
	"self updatePackagesListLabel."
	self updateItemsListLabel.
]

{ #category : #initialization }
DTMutationPluginPresenter >> updatePresenter [

	super updatePresenter.

	self updatePackagesList.
	self updateResultViewsDropList.
	self updateSelectionViewsDropList.
	
	"selectionViewsDropList whenSelectionChangedDo: [ :optionSelected |  self whenSelectionOptionChanged: optionSelected ] ."

	startButton label: plugin startButtonLabel.
	startButton help: plugin startButtonHelp
]

{ #category : #'as yet unclassified' }
DTMutationPluginPresenter >> updateSelectionViewsDropList [
	| newPragmas |

	newPragmas := plugin selectionOptionViews.
	(selectionViewsDropList listItems = newPragmas
		and: [ newPragmas isNotEmpty ])
		ifTrue: [ "no entra aqui"
			"Trigger action attached to selection change."
			selectionViewsDropList selectedIndex: selectionViewsDropList selectedIndex.
			^ self ].

	self selectionViewsDropList selectedItem
		ifNotNil: [ self selectionViewsDropList resetSelection ].
	self selectionViewsDropList items: newPragmas.
	newPragmas isNotEmpty
		ifTrue: [ self selectionViewsDropList selectIndex: 1 ]
]