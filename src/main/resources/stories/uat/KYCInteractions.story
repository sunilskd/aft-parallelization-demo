Epic: Ownership, Subsidiaries, Full Graph

This story is to cover the expected functionality when user applies multiple highlights or filters since they react to each other in various ways.

Covers below features:
JIRA ID - KYC-266 - Interaction between percent filter and direct/indirect filter on all graphs
JIRA ID - KYC 265 - Interaction between filters and highlights on all graphs

Meta:@kycinteractionsLive @kyclive

Scenario: KYC user login
Given the user is on bankers almanac page
When the user login as a kyc user to bankers almanac page

Scenario: KYC user views full graph
a. 0. An entity on the graph (could be entity user is viewing) has owner that is a legal entity which is active, display that entity as owner on graph above the entity it owns.
   1. Ownership relationship has percent ownership, display percent on owner's node on graph
   2. Ownership relationship has null percent ownership, do not display percent ownership on owner node on graph
   3. Free text ownership exists for entity user is viewing, display that free text in a node as a direct owner of the root node
   4. Free text ownership does not exist for entity user is viewing, do not display free text as owner on full graph
   5. Entity on the graph (could be entity user is viewing or another subsidiary entity on graph) has at least one active relationship where it is the owner and the owned entity is also active, display owned entity as subsidiary on graph and display percent ownership on subsidiary
   6. Entity on the subsidiary portion of graph has an inactive relationship where it is the owner, then do not display owned entity on graph
   7. Subsidiary relationship has percent ownership, display percent ownership on the subsidiary node
   8. Subsidiary relationship has null percent ownership, do not display a percent ownership on the subsidiary node
   9. Subsidiary graph should not display the free text
   10. User will see in product message on owners graph if they do not have access to UBO data and UBOs exisits fot the entity user is viewing.
   11. "No country highlight" is default selection in country highlight drop-down
   12. List country of operations for legal entities that appear on the graph in highlight drop-down, each unique country appearing once, sort countries alphabetically by country name
   13. Select a country highlight, legal entities in the full graph that have that country of operations are highlighted (including root node of graph if applicable)
   14. If user selects a second country in highlight drop-down, highlight legal entities by new selected country and remove highlight of legal entities by previous country)
   15. Select "No country highlight", removes country highlight of legal entities
   16. By default, percent filter is set to 0 for both input box and slider, all owners are displayed in the graph
   17. If user enters a number between 1-100 in input box, slider position automatically updates to match percent entered, only owners that are owned by equal to or greater than selected percent appear on the graph
   18. User selects "Direct Relationships Only", then graph updates to only show direct owners (level 1 of graph)
   19. By default UBO highlight checkbox is available on full graph, but is disabled for KYC user and not selectable
   20. Display the free text when the filters are applied
   21. Verify Country highlight drop-down only lists country of operations for legal entities displayed on the graph, not entities that were truncated and not displayed
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the group structure tab
And the user clicks on the graph button
Then the user should see the legal entity Banco Indusval SA, user is currently viewing, as the root and highlighted on the graphs
When the user resize graph to translate(1003.9459234383133,436.36120867136754) scale(0.27509397800157526)
Then the user should see the list of owners in level 2, above the root entity, in the graphs
And the user should see the list of owners in level 3, above the root entity, in the graphs
And the user should see the list of subsidiaries in level 2, below the root entity, in the graphs
And the user should see the notification message that the graphs are truncated as it has more than 125 triples and ownership relationship exists with percent less than 5
And the kyc user should see message displayed there is ubo data available for this entity. you currently do not have access to this data, please subscribe in the graphs
Then the user should see the ultimate beneficial owners filter checkbox disabled in the graph
When the user clicks on <legalEntity> node which appears more than once in the graphs
Then the user should see the nodes for <legalEntity> highlighted everywhere it appears in the graphs
Then the user should see no country highlight selected by default in country highlight drop-down in the graphs
When the user selects a country UK from the country highlight list in the graphs
Then the user should see the below entities that have the selected country of operations highlighted in the graphs
|NODES|
|Generation Investment Management Ll|

When the user selects another country Belgium from the country highlight list in the graphs
Then the user should see the below entities that have the selected country of operations highlighted in the graphs
|NODES|
|The Bank of New York Mellon SA/NV 10|

When the user de-selects the selected country by selecting No country highlight from the country highlight list in the graphs
Then the user should not see the entities highlighted in the graphs

Then the user should see, by default, percent filter set to 0 for both input box and slider, in the graphs
When the user enters percentage as 68 in ownership percentage filter text box in the graphs
Then the user should see the list of below unique country of operations for each owners to highlight, sorted alphabetically, in the graphs
|COUNTRIES|
|No country highlight|
|Brazil (9)|

Then the user should not see any nodes in level 2, above the root entity, in the graphs
Then the user should see the list of subsidiaries in level 2, below the root entity, in the graphs
Then the user should not see any nodes in level 3, below the root entity, in the graphs

When the user clicks on direct relationship only filter checkbox in the graphs
Then the user should not see any nodes in level 2, above the root entity, in the graphs
Then the user should not see any nodes in level 2, below the root entity, in the graphs

When the user clicks on please subscribe link in the message displayed in the graph
Then the user is taken to subscription page URL http://accuity.lookbookhq.com/bankers-almanac-ubo/video?cmpid=ILC7CBRSK7CBAFPU-2016-0810-GLOB-ba-ubo7CLookBook&sfid=701D0000000dwwH on accuity.com

Examples:
|fid|legalEntity|
|732|MSL Inc|

Scenario: KYC user logout
Given the user is on bankers almanac page
When the user logout from banker almanac page