Epic: UBO

A KYC analyst has to follow a due diligence process to satisfy legal requirements to prove that any potential business partnerships
will not result in funding illegal activities such as money laundering and terrorist financing. A key part of this process is to prove that there are
no owners, including an ultimate beneficial owner which is a natural person, of the bank they will potentially do business with which are politically exposed
or known to be involved in criminal activities. A UBO user of the application has paid for premium access, which includes the
same access as a KYC user but with additional data about UBOs (people).

UBO user has access to below entity types -
1. Legal Entities
2. People
3. Other entity types (non-person, non-entity)

UBO user does not have access to below entity types -
1. Free text ownership

Covers below features:
JIRA ID - KYC-37 - KYC user can filter owners graph by percent ownership
JIRA ID - KYC-138 - Owners Graph - Direct-Indirect filter
JIRA ID - KYC-105 - KYC user can highlight legal entities by country in ownership graph
JIRA ID - KYC-49 - UBO user can view ownership graph with UBOs
JIRA ID - KYC-114 - UBO user can view non-person, non-entity owners on owners graph
JIRA ID - KYC-33 - KYC user can see visual indicator for entity that appears multiple times in the ownership graph
JIRA ID - KYC-229 - UBO user can highlight UBOs on graph
JIRA ID - KYC-386 - User can click "more" link from truncated graph to open another graph
JIRA ID - KYC-455 - new truncation logic owners graph

Meta:@uboownersgraph @ubo

Scenario: KYC user login
Given the user is on the ubo login page
When the user login as a ubo user

Scenario: Covers below scenarios
a. By Default checkbox for Direct relationship is not selected
b. If no owners are present, filter is still available
c. If there are no owners beyond level 1 direct relationships, filter is still available
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the direct relationship only filter checkbox unchecked by default in the graphs
Then the ubo user should not see message displayed there is ubo data available for this entity. you currently do not have access to this data, please subscribe in the graphs

Examples:
|fid|
|LE-6|
|LE-55|
|LE-61|

Scenario: Scenario 1
.Description
----
a. 0. User selects "Direct Relationships Only", then graph updates to only show direct owners (level 1 of graph)
   1. User un-checks "Direct Relationships Only" box, then graph updates to show all owners in any level
   2. An entity on the graph (could be entity user is viewing) has owner that is a legal entity which is active, display that entity on the owners graph above the entity it owns.
   3. Owner has percent ownership, display percent on owner's node on graph
   4. Owner has null percent ownership, do not display percent ownership on owner node on graph
   5. Entity user is viewing has free text ownership, do not display on the owners graph for UBO user
   6. Entity on owners graph has non-institution, non-person entity type owner and the relationship is active, display that owner on the graph
   7. non-institution, non-person entity type owner has percent ownership, display on the owner's node
   8. non-institution, non-person entity type owner has null percent ownership, do not display percent ownership on owner's node
   9. non-institution, non-person entity type owner has value for owner type and description, display owner type and description
   10. If non-institution, non-person entity type owner has a value for owner type but no value for description, only display owner type in node
----
image:UBOOwnersGraph-Scenario-1.png[Scenario 1]
----
----
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
When the user clicks on direct relationship only filter checkbox in the graphs
Then the user should see the legal entity QA Legal Entity 6, user is currently viewing, as the root and highlighted on the graphs
And the user should see the list of owners in level 1, above the root entity, in the graphs
When the user unchecks direct relationship only filter checkbox in the graphs
Then the user should see the legal entity QA Legal Entity 6, user is currently viewing, as the root and highlighted on the graphs

And the user should see the list of owners in level 1, above the root entity, in the graphs
And the user should see the list of owners in level 2, above the root entity, in the graphs
And the user should see the list of owners in level 3, above the root entity, in the graphs
And the user should see the list of owners in level 4, above the root entity, in the graphs
And the user should see the list of owners in level 5, above the root entity, in the graphs
And the user should see the list of owners in level 6, above the root entity, in the graphs

Examples:
|fid|
|LE-6|

Scenario: Covers below scenarios
a. 0. Entity user is viewing does not have any active relationships to owners, display message "No known entities."
   1. Entity user is viewing does not have any owners, display message "No known entities."
b. 0. If owner is type person but the relationship is inactive, do not display that person as owner on the graph
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see message displayed in place of graph explaining there are no entities in the graphs

Examples:
|fid|
|LE-32|
|LE-F|

Scenario: Scenario 3
.Description
----
a. 0. An entity on the graph (could be entity user is viewing) has owner that is a legal entity which is inactive, do not display that entity as an owner on the graph
   1. An entity on the graph (could be entity user is viewing) has owner that is a legal entity but the relationship is inactive, do not display that entity as an owner on the graph
   2. If entity on owners graph has non-institution, non-person entity type owner but the relationship is inactive, do not display that owner on the graph
----
image:UBOOwnersGraph-Scenario-2.png[Scenario 2]
----
----
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity 23, user is currently viewing, as the root and highlighted on the graphs

And the user should see the list of owners in level 1, above the root entity, in the graphs
And the user should see the list of owners in level 2, above the root entity, in the graphs
And the user should see the list of owners in level 3, above the root entity, in the graphs

Examples:
|fid|
|LE-23|

Scenario: Scenario 3
.Description
----
a. Entity (including entity user is viewing) appears in the same path of the graph more than once, then stop traversing path after second appearance only displaying an entity a maximum of two times in one path
----
image:UBOOwnersGraph-Scenario-3.png[Scenario 3]
----
----
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity 56, user is currently viewing, as the root and highlighted on the graphs

And the user should see the list of owners in level 1, above the root entity, in the graphs
And the user should see the list of owners in level 2, above the root entity, in the graphs
And the user should see the list of owners in level 3, above the root entity, in the graphs
Then the user should not see any nodes in level 4, above the root entity, in the owners graph

Examples:
|fid|
|LE-56|

Scenario: Scenario 4
.Description
----
To verify circular relationship
----
image:UBOOwnersGraph-Scenario-4.png[Scenario 4]
----
----
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity 51, user is currently viewing, as the root and highlighted on the graphs

And the user should see the list of owners in level 1, above the root entity, in the graphs
And the user should see the list of owners in level 2, above the root entity, in the graphs
Examples:
|fid|
|LE-51|

Scenario: To verify owners graph when entity user is viewing is also an owner of the same entity
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity Vontobel Holding AG, user is currently viewing, as the root and highlighted on the graphs

And the user should see the list of owners in level 1, above the root entity, in the graphs

Examples:
|fid|
|11262|

Scenario: Scenario 5
.Description
----
Scenario: Covers below scenarios
a. 0. Entity user is viewing has owners that are type person and the relationship is active, display those owners on the graph
   1. Person owner has percent ownership, display percent on owner's node on graph
----
image:UBOOwnersGraph-Scenario-5.png[Scenario 5]
----
----
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity A, user is currently viewing, as the root and highlighted on the graphs

And the user should see the list of owners in level 1, above the root entity, in the graphs
And the user should see the list of owners in level 2, above the root entity, in the graphs
And the user should see the list of owners in level 3, above the root entity, in the graphs

Examples:
|fid|
|LE-A|

Scenario: Person owner has null percent ownership, do not display percent ownership on owner node on graph
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity 30, user is currently viewing, as the root and highlighted on the graphs

And the user should see the list of owners in level 1, above the root entity, in the graphs

Examples:
|fid|
|LE-30|

Scenario: Covers below scenarios
a. 0. "No country highlight" is default selection in country highlight drop-down
   1. List country of operations for legal entities that appear on the graph in highlight drop-down, each unique country appearing once, sort countries alphabetically by country name
   2. Select a country highlight, legal entities in the owners graph that have that country of operations are highlighted (including root node of graph if applicable)
   3. If user selects a second country in highlight drop-down, highlight legal entities by new selected country and remove highlight of legal entities by previous country)
   4. Select "No country highlight", removes country highlight of legal entities
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see no country highlight selected by default in country highlight drop-down in the graphs
And the user should see the list of below unique country of operations for each owners to highlight, sorted alphabetically, in the graphs
|COUNTRIES|
|No country highlight|
|UK (7)|
|USA (5)|

When the user selects a country UK from the country highlight list in the graphs
Then the user should see the below entities that have the selected country of operations highlighted in the graphs
|NODES|
|QA Legal Entity 6|
|QA Legal Entity 10|
|QA Legal Entity 9|
|QA Legal Entity 11|
|QA Legal Entity 12|
|QA Legal Entity 14|
|QA Legal Entity 13|

When the user selects a country USA from the country highlight list in the graphs
Then the user should see the below entities that have the selected country of operations highlighted in the graphs
|NODES|
|QA Legal Entity 16|
|QA Legal Entity 18|
|QA Legal Entity 17|
|QA Legal Entity 19|
|QA Legal Entity 15|

When the user de-selects the selected country by selecting No country highlight from the country highlight list in the graphs
Then the user should not see the entities highlighted in the graphs

Examples:
|fid|
|LE-6|

Scenario: Country list is sorted alphabetically.
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see no country highlight selected by default in country highlight drop-down in the graphs
And the user should see the list of below unique country of operations for each owners to highlight, sorted alphabetically, in the graphs
|COUNTRIES|
|No country highlight|
|Canada (2)|
|Italy (12)|
|Norway (2)|
|South Africa (3)|
|UK (1)|
|USA (92)|

Examples:
|fid|
|444|

Scenario: Country list displaying root node country's
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see no country highlight selected by default in country highlight drop-down in the graphs
And the user should see the list of below unique country of operations for each owners to highlight, sorted alphabetically, in the graphs
|COUNTRIES|
|No country highlight|
|UK (1)|
|USA (4)|

Examples:
|fid|
|LE-9|

Scenario: Covers below scenarios
a. By default, percent filter is set to 0 for both input box and slider, all owners are displayed in the graph
b. If user enters a number between 1-100 in input box, slider position automatically updates to match percent entered, only owners that are owned by equal to or greater than selected percent appear on the graph
c. If user enters 0 in input box, slider position automatically updates to match percent entered, all owners appear on the graph
d. If user enters number greater than 100 in input box, input box automatically updates to display 100, slider bar automatically moves to 100, only owners that are owned by 100 percent appear on graph
e. If user enters a character than is not a number in the input box, input box automatically updates to display 0, slider bar automatically moves to 0, all owners are displayed in the graph
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see, by default, percent filter set to 0 for both input box and slider, in the graphs
When the user enters percentage as 25 in ownership percentage filter text box in the graphs
Then the user should see the legal entity QA Legal Entity A, user is currently viewing, as the root and highlighted on the graphs

And the user should see the list of owners in level 1, above the root entity, in the graphs
And the user should see the list of owners in level 2, above the root entity, in the graphs
And the user should see the list of owners in level 3, above the root entity, in the graphs
When the user enters percentage as 0 in ownership percentage filter text box in the graphs
Then the user should see the legal entity QA Legal Entity A, user is currently viewing, as the root and highlighted on the graphs

And the user should see the list of owners in level 2, above the root entity, in the graphs
And the user should see the list of owners in level 3, above the root entity, in the graphs
When the user enters percentage as 100 in ownership percentage filter text box in the graphs
Then the user should see the legal entity QA Legal Entity A, user is currently viewing, as the root and highlighted on the graphs
And the user should not see any nodes in level 2, above the root entity, in the owners graph

When the user enters percentage as 200 in ownership percentage filter text box in the graphs
Then the user should see the legal entity QA Legal Entity A, user is currently viewing, as the root and highlighted on the graphs
And the user should not see any nodes in level 2, above the root entity, in the owners graph
And the user should see, percent filter is reset to 100 for both input box and slider, in the graphs

When the user enters percentage as abc in ownership percentage filter text box in the graphs
Then the user should see the legal entity QA Legal Entity A, user is currently viewing, as the root and highlighted on the graphs
And the user should see the list of owners in level 2, above the root entity, in the graphs
And the user should see the list of owners in level 3, above the root entity, in the graphs

Examples:
|fid|
|LE-A|

Scenario: Covers below scenarios
a. 0. If user moves slider to percent 1-100, null percent owners are filtered out and not displayed on the graph, input box automatically updates to reflect percent selected by slider, only owners that are owned by equal to or greater than selected percent appear on the graph
   1. If user moves slider to 0 percent, all owners appear on graph
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
And the user uses the slider to changes the percent ownership in increments of whole numbers, ranging from 0 to 100, to 40 in the graph

Then the user should see the list of owners in level 1, above the root entity, in the graphs
Then the user should see the list of owners in level 2, above the root entity, in the graphs
Then the user should see the list of owners in level 3, above the root entity, in the graphs

Examples:
|fid|
|LE-A|

Scenario: User applies percent filter that results in no owners on the graph, only root node is left on the graph
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
When the user enters percentage as 51 in ownership percentage filter text box in the graphs
Then the user should see the legal entity QA Legal Entity A, user is currently viewing, as the root and highlighted on the graphs

Examples:
|fid|
|LE-A|

Scenario: Percent filter should not filter out non-entity non-person
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see, by default, percent filter set to 0 for both input box and slider, in the graphs
When the user enters percentage as 25 in ownership percentage filter text box in the graphs
Then the user should see the legal entity QA Legal Entity 61, user is currently viewing, as the root and highlighted on the graphs

And the user should see the list of owners in level 1, above the root entity, in the graphs
Examples:
|fid|
|LE-61|

Scenario: Verify tool tip displays legal title in graphs
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity 6, user is currently viewing, as the root and highlighted on the graphs
Then the user should see the legal title displayed in the nodes when the user hovers over it in the graphs
|LEGAL TITLE|
|QA Legal Entity 6|
|QA Legal Entity 9|
|QA Legal Entity 10|
|QA Legal Entity 16|
|QA Legal Entity 18|
|QA Legal Entity 11|
|QA Legal Entity 14|
|QA Legal Entity 12|
|QA Legal Entity 17|
|QA Legal Entity 19|
|Others|
|QA Legal Entity 15|
|QA Legal Entity 13|
|QA Legal Entity 61|
|QA Legal Entity 61|
|QA Legal Entity 61|
|QA Test Person 1|
|QA Test Person 1|
|QA Test Person 2|
|Local Government, Legal Entity 61 owned by Local Government|
|Local Government, Legal Entity 61 owned by Local Government|
|Free float, Legal Entity 15 owned by Free float|
|QA Test Person 1|
|Local Government, Legal Entity 61 owned by Local Government|

Examples:
|fid|
|LE-6|

Scenario: Covers below scenarios
a. 0. Root node appears in multiple times in the same path
   1. Visual indicator count doesnt change even filter is applied
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity 56, user is currently viewing, as the root and highlighted on the graphs
And the user should see the multiple appearance bar for <legalEntity> indicating the number of times, <countValue> ,it appears in the graphs
When the user clicks on direct relationship only filter checkbox in the graphs
Then the user should see the multiple appearance bar for <legalEntity> indicating the number of times, <countValue> ,it appears in the graphs

Examples:
|fid|legalEntity|countValue|
|LE-56|QA Legal Entity 56|Appears: 2|

Scenario: Covers below scenarios
a. 0. Legal Entity appears at multiple levels
   1. Legal Entity appears at multiple levels is highlighted when clicked on one of the occurances
   2. Visual indentifier must not be displayed when Non-person/Non-legal Entities appear multiple times on the graph
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity 6, user is currently viewing, as the root and highlighted on the graphs
And the user should see the multiple appearance bar for <legalEntity> indicating the number of times, <countValue> ,it appears in the graphs
When the user clicks on <legalEntity> node which appears more than once in the graphs
Then the user should see the nodes for <legalEntity> highlighted everywhere it appears in the graphs
And the user should not see the visual indicator displayed for non-person/non-entity when appeared multiple time for <entity> in the graphs
And the user should not see the multiple appearance bar for subsidiaries indicating the number of times it appears in the graphs

Examples:
|fid|legalEntity|countValue|entity|
|LE-6|QA Legal Entity 61|Appears: 3|Local Government, Legal Entity 61 owned by Local Government|

Scenario: Covers below scenarios
a. 0. Person appears at multiple levels
   1. Person appears at multiple levels is highlighted when clicked on one of the occurances
   2. Visual indentifier must not be displayed when Non-person/Non-legal Entities appear multiple times on the graph
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity 6, user is currently viewing, as the root and highlighted on the graphs
And the user should see the multiple appearance bar for <legalEntity> indicating the number of times, <countValue> ,it appears in the graphs
When the user clicks on <legalEntity> node which appears more than once in the graphs
Then the user should see the nodes for <legalEntity> highlighted everywhere it appears in the graphs
And the user should not see the visual indicator displayed for non-person/non-entity when appeared multiple time for <entity> in the graphs
And the user should not see the multiple appearance bar for subsidiaries indicating the number of times it appears in the graphs

Examples:
|fid|legalEntity|countValue|entity|
|LE-6|QA Test Person 1|Appears: 3|Local Government, Legal Entity 61 owned by Local Government|

Scenario: Visual Indicator not been displayed for Legal entities which are displayed only once
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity 9, user is currently viewing, as the root and highlighted on the graphs
And the user should not see visual indicator for legal entity <legalEntity>, when displayed only once

Examples:
|fid|legalEntity|
|LE-9|QA Legal Entity 16|

Scenario: Visual Indicator not been displayed for persons with same name but different fid's
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity A, user is currently viewing, as the root and highlighted on the graphs
And the user should not see the visual indicator for entity with same name but different fid <legalEntity>

Examples:
|fid|legalEntity|
|LE-A|QA Test Person A|

Scenario: Covers below scenarios
a. 0. By default UBO checkbox is available but not checked
   1. If graph has UBOs (owners that are type person), checkbox is clickable
   2. User checks UBO highlight box, all person owners in the graph are highlighted
   3. User unchecks UBO highlight box, highlight is removed from person owners
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the ultimate beneficial owners filter checkbox unchecked by default in the graph
When the user clicks on the ultimate beneficial owners filter checkbox in the graph
Then the user should see the ultimate beneficial owners highlighted in the graph
|NODES|
|QA Test Person A|
|QA Test Person E|
|QA Test Person A|
|QA Test Person G|
|QA Test Person D|
|QA Test Person G|
|QA Test Person B|
|QA Test Person G|
|QA Test Person H|
|QA Test Person C|

When the user clicks on the ultimate beneficial owners filter checkbox in the graph
Then the user should see the highlight removed from ultimate beneficial owners in the graph

Examples:
|fid|
|LE-A|

Scenario: If graph does not have any UBOs, checkbox is not clickable
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the ultimate beneficial owners filter checkbox disabled in the graph

Examples:
|fid|
|LE-60|

Scenario: Verify parent child relationship
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the legal entity QA Legal Entity 6, user is currently viewing, as the root and highlighted on the graphs

Then the user should see the owners for the legal entity QA Legal Entity 11 in the graphs
Then the user should see the owners for the legal entity QA Legal Entity 15 in the graphs
Then the user should see the owners for the legal entity QA Legal Entity 61 in the graphs

Examples:
|fid|
|LE-6|

Scenario: Verify in product message is not displaying for the users with UBO access
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the direct relationship only filter checkbox unchecked by default in the graphs
Then the ubo user should not see message displayed there is ubo data available for this entity. you currently do not have access to this data, please subscribe in the graphs

Examples:
|fid|
|LE-6|

Scenario: User clicks on show more link and user is navigated to the respective graph page of that entity
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
And the user enters percentage as 35 in ownership percentage filter text box in the graphs
And the user resize graph to translate(-9890.090379357129,1093.2601537970945) scale(0.604)
And the user clicks on show more link which appears on the legal entity node <nodeTitle> in the graphs
Then user is taken to the respective graph page of that legal entity <nodeTitle>

Examples:
|fid|nodeTitle|
|51859|Banco Santander SA|

Scenario: KYC-395 Verify Percent ownership filter works the same for truncated graphs, filtering nodes currently displayed on the graph
Given the user is on the ubo login page
When the user login as a kyc user
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
When the user enters percentage as 5 in ownership percentage filter text box in the graphs
Then the user should see the owners for the legal entity Caisse d'épargne et de prévoyance Ile de France in the graphs

Examples:
|fid|
|175270|

Scenario: Verify graph truncation notification message
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the notification message that the graphs are truncated

Examples:
|fid|
|544|

Scenario: Covers below scenarios for truncated owners graph for UBO user.
a. 0. When triples are >125, then nodes with less than 5% are displayed but not the nodes potentially be after that node.
   1. When triples are >125 & an entity appears more than once, then only display path beyond the first left most occurance and do not display path beyond other appearances
   2. When triples are >125 & an entity appears more than once & first occurance has less than 5% ownership, then truncate the graph and display the path of second appearances
   3. Null percent ownership do NOT trigger truncation. They are treated like 100% in this case
   4. Display notification message "This graph is too large to display in full. To make this information viewable in your browser, we have removed relationships that appear multiple times or have less than 5% ownership. Click the “show more” link on tiles to view hidden segments in a new graph."
   5. UBO highlight is disabled for UBO and KYC user
   6. Country highlight drop-down only displays country of operations of LEs displayed after truncation
   7. "Appears count" on tiles only reflects appearances on the graph after truncation
   8. click “show more” link on tiles to view hidden segments in a new graph.
Given the user is on the ubo login page
When the user login as a ubo user
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
And the user resize graph to translate(955.6692913385826,367.47401301707407) scale(0.11800000000000001)
When the user selects a country USA from the country highlight list in the graphs
When the user clicks on <legalEntity> node which appears more than once in the graphs
When the user captures the actual snapshot for the <nodeTitle> full graph
Then the user should see the actual snapshot matching the expected snapshot for <nodeTitle> owners graph
And the user should see the list of below unique country of operations for each owners to highlight, sorted alphabetically, in the graphs
|COUNTRIES|
|No country highlight|
|Belgium (1)|
|Canada (2)|
|Cayman Islands (1)|
|France (3)|
|Germany (2)|
|Guernsey (2)|
|Hong Kong (1)|
|Luxembourg (1)|
|Portugal (1)|
|UK (8)|
|USA (33)|

When the user resize graph to translate(1253.1793966674943,1695.3853983257395) scale(0.55)
And the user clicks on show more link which appears on the legal entity node <nodeTitle> in the graphs
Then user is taken to the respective graph page of that legal entity <nodeTitle>

Examples:
|fid|nodeTitle|legalEntity|
|149414|Landmark Directors Limited|Blackrock Inc|

Scenario: Covers below scenarios for truncated owners graph for a UBO user.
a. 0. Verify graph truncation notification message when number of nodes are greater than 2500
   1. Percent ownership filter options not affected by truncation.
Given the user is on the ubo login page
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
Then the user should see the notification message that the graphs are truncated when there are more than 2500 nodes
When the user enters percentage as 7 in ownership percentage filter text box in the graphs
And the user resize graph to translate(762.8473892309161,444.76565489373127) scale(0.1)
Then the user should see the list of owners in level 12, above the root entity, in the graphs

Examples:
|fid|
|250786|

Scenario: KYC user logout
Meta: @id logout
Given the user is on the ubo login page
When the user logout