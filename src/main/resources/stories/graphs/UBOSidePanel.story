Epic: Ownership, Subsidiaries, Full Graph
----
.Overall Report

image:.graphs.UBOSidePanel.stats.png
----

Covers below features:
JIRA ID - KYC-147 pop open panel for more entity info on owners graph
JIRA ID - KYC-294 KYC user can view UBO list header in owners list and side panel
JIRA ID - KYC-338 No Known Entities" should be displayed when there are no direct subs or UBOs
JIRA ID - KYC-353 Percentage ownership is truncating the 2nd decimal value if it is zero.
JIRA ID - KYC-16 KYC user can click link to another entity in owners graph
JIRA ID - KYC-273 User can click link to another entity in full graph
JIRA ID - KYC-73 KYC user can click link to another entity in subsidiary graph
JIRA ID - KYC-330 Remove links for person,non-entity or non-person in graphs.
JIRA ID - KYC-272 - User can view website in side panel for legal entity on a graph
JIRA ID - KYC-484 - Display zip code for addresses in entity details

Meta:@ubosidepanel @ubo

Scenario: KYC user login
Given the user is on the ubo login page
When the user login as a ubo user

Scenario: View side panel for legal entity on owners graph
a. 0. User clicks title of legal entity on node (could be owner on graph or root node), side panel opens with more details about the entity
   1. With head office address elements with varying "UseInAddress" flag value true for each element (display element if UseInAddress is true)
   2. With head office address elements with varying "UseInAddress" flag value false for each element (do not display element if UseInAddress is false)
   3. Entity With website, display hyperlink in details section of side panel
   4. Displaye zip code in head office address position as afterArea
b. 0. Active regulation relationships exist for entity user is viewing, display in entity details summary section sorted alphabetically by legal title
   1. If active stock exchange relationship(s) exist, display legal title of stock exchange sort first by primary = true, then by legal title
   2. Displaye zip code in head office address position as beforeCity
c. 0. If no regulation relationship exists, then display field label but no value
   1. If no stock exchange relationship exists, display field label but no value
   2. Displaye zip code in head office address position as afterSubArea
d. 0. If no primary physical address exists for head office, display field label but no value
   1. If inactive stock exchange relationship, then display field label but no value
   2. If only inactive regulation relationship exists, then display field label but no value
   3. If website is null, display field label in details section of side panel but no value
e. Displaye zip code in head office address position as afterCity
f. Displaye zip code in head office address position as beforeSubArea
g. Displaye zip code in head office address position as beforeArea
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
And the user resize graph to translate(951.5,387) scale(0.9910000000000001)
When the user clicks on direct relationship only filter checkbox in the graphs
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see complete head office address, regulators , stock exchanges and website in details section of side panel for the node user clicked in the graphs

Examples:
|fid|nodeTitle|
|1038|BOA|
|58285|Berlin Hyp AG|
|52147|London Stock Exchange Plc|
|LE-6|QA Legal Entity 6|
|240817|Wuhu Yangzi Rural Commercial Bank|
|3979|HSBC Private Bank (UK) Limited|
|131845|Citizens Bank of Pennsylvania|

Scenario: Covers below scenarios
a. 0. If multiple active subsidiary relationships exist and are displayed on list, order by percent ownership first then by legal title
   1. If percent ownership exists for subsidiary relationship, display in list next to subsidiary
   2. If percent ownership is null, do not display a percent ownership next to subsidiary on list
   3. If country of operations exists for subsidiary entity, display next to subsidiary on list
   4. If country of operations does not exist for subsidiary entity, do not display next to subsidiary on list
   5. If active subsidiary relationship exists, display that subsidiary on the directly owns list
   6. User clicks close icon, side panel hides
b. 0. If subsidiary relationship exists but subsidiary entity is inactive, do not display that subsidiary on the directly owns list
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
And the user resize graph to translate(951.5,387) scale(0.9910000000000001)
When the user clicks on direct relationship only filter checkbox in the graphs
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see list of direct subsidiaries with entity title, country and percentage ownership in directly owns section of side panel for the node user clicked in the graphs

Examples:
|fid|nodeTitle|
|146115|Investec Holdings (Ireland) Ltd|
|200|Public Bank (Hong Kong) Limited|

Scenario: If inactive subsidiary relationship exists, do not display that subsidiary on the directly owns list
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
When the user clicks on direct relationship only filter checkbox in the graphs
And the user resize graph to translate(1022.9216796875,392.1518898391724) scale(0.9910000000000001)
When the user clicks on the tile of the another legal entity <switchNode> (including the entity of interest) in the graphs
Then the user should see list of direct subsidiaries with entity title, country and percentage ownership in directly owns section of side panel for the node user clicked in the graphs

Examples:
|fid|switchNode|
|13408|Berliner Volksbank eG|

Scenario: Covers below scenarios
A. 0. If active relationship to person owner exists for legal entity user selected or any entity in its path of ownership, display that person in the UBO list and display the legal title of the entity it directly owns
   1. If inactive relationship to person owner exists for legal entity user selected or any entity in its path of ownership, do not display that person in the UBO list
   2. If multiple people appear in the UBO list, sort by percent ownership first then by name
   3. If UBO relationship has percent ownership, display next to person on UBO list
   4. User clicks close icon, side panel hides
   5. User clicks someplace else on screen outside of side panel, panel does not close
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see list of ubos with name, entity and percentage ownership in ubo section of side panel for the node <nodeTitle> user clicked in the graphs
|UBO NAME|ENTITY|PERCENTAGE OWNERSHIP|
|QA Test Person C|QA Legal Entity D|50.52|
|QA Test Person G|QA Legal Entity B|50.222|
|QA Test Person D|QA Legal Entity C|49.23|
|QA Test Person E|QA Legal Entity A|49.23|
|QA Test Person H|QA Legal Entity D|49.23|
|QA Test Person A|QA Legal Entity A|45.52|
|QA Test Person A|QA Legal Entity A|45.52|
|QA Test Person B|QA Legal Entity B|40.23|
|QA Test Person G|QA Legal Entity C|4.93|
|QA Test Person G|QA Legal Entity D|4.23|

When the user clicks on direct relationship only filter checkbox in the graphs
Then the user should see the side panel still open in the graphs
When the user clicks on close button on the side panel in the graphs
Then the user should see the side panel closed and should be able to continue in the graphs

Examples:
|fid|nodeTitle|
|LE-A|QA Legal Entity A|

Scenario: If UBO relationship has null percent ownership, do not display percent next to person on UBO list
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
And the user resize graph to translate(951.5,362.39999396514895) scale(0.9910000000000001)
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see list of ubos with name, entity and percentage ownership in ubo section of side panel for the node <nodeTitle> user clicked in the graphs
|UBO NAME|ENTITY|PERCENTAGE OWNERSHIP|
|QA Test Person 2|QA Legal Entity 30||

Examples:
|fid|nodeTitle|
|LE-7|QA Legal Entity 7|

Scenario: display "No Known Entities" if there are no direct subsidiaries
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button

And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see message displayed in side panel in place of list explaining there are no directly owned entities in the graphs

Examples:
|fid|nodeTitle|
|LE-34|QA Legal Entity 34|

Scenario: display "No Known Entities" under ubo section for kyc user
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
And the user resize graph to translate(702.8282562866211,316.0790002822876) scale(0.9910000000000001)
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see message displayed in side panel in place of list explaining there are no ultimate beneficial owners in the graphs

Examples:
|fid|nodeTitle|
|3528|National Bank of Yemen|

Scenario: User clicks on another node, side panel should refresh with updated information
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
And the user resize graph to translate(952.820475589077,491.2693776010915) scale(0.9730000000000001)
When the user enters percentage as 73 in ownership percentage filter text box in the graphs
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see message displayed in side panel in place of list explaining there are no ultimate beneficial owners in the graphs
When the user clicks on the tile of the another legal entity <switchNode> (including the entity of interest) in the graphs
Then the user should see list of direct subsidiaries with entity title, country and percentage ownership in directly owns section of side panel for the node user clicked in the graphs

Examples:
|fid|nodeTitle|switchNode|
|200|Public Bank (Hong Kong) Limited|Public Bank Berhad|

Scenario: View side panel for legal entity on subsidiaries graph
a. 0. User clicks title of legal entity on node (could be owner on graph or root node), side panel opens with more details about the entity
   1. With head office address elements with varying "UseInAddress" flag value true for each element (display element if UseInAddress is true)
   2. With head office address elements with varying "UseInAddress" flag value false for each element (do not display element if UseInAddress is false)
   3. User clicks close icon, side panel hides
   4. User clicks someplace else on screen outside of side panel, panel does not close
   5. Entity With website, display hyperlink in details section of side panel
b. 0. Active regulation relationships exist for entity user is viewing, display in entity details summary section sorted alphabetically by legal title
   1. If active stock exchange relationship(s) exist, display legal title of stock exchange sort first by primary = true, then by legal title
c. 0. If no regulation relationship exists, then display field label but no value
   1. If no stock exchange relationship exists, display field label but no value
d. 0. If no primary physical address exists for head office, display field label but no value
   1. If inactive stock exchange relationship, then display field label but no value
   2. If only inactive regulation relationship exists, then display field label but no value
   3. If website is null, display field label in details section of side panel but no value
e. If multiple websites are present, then display one website, whichever is found first on the details section of side panel
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the subsidiaries tab
And the user clicks on the graph button
When the user clicks on direct relationship only filter checkbox in the graphs
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see complete head office address, regulators , stock exchanges and website in details section of side panel for the node user clicked in the graphs
When the user clicks on direct relationship only filter checkbox in the graphs
Then the user should see the side panel still open in the graphs
When the user clicks on close button on the side panel in the graphs
Then the user should see the side panel closed and should be able to continue in the graphs

Examples:
|fid|nodeTitle|
|1038|BOA|
|58285|Berlin Hyp AG|
|LE-C|QA Legal Entity C|
|LE-6|QA Legal Entity 6|
|732|Banco Indusval SA|

Scenario: Covers below scenarios
a. 0. If multiple active subsidiary relationships exist and are displayed on list, order by percent ownership first then by legal title
   1. If percent ownership exists for subsidiary relationship, display in list next to subsidiary
   2. If percent ownership is null, do not display a percent ownership next to subsidiary on list
   3. If country of operations exists for subsidiary entity, display next to subsidiary on list
   4. If country of operations does not exist for subsidiary entity, do not display next to subsidiary on list
   5. If active subsidiary relationship exists, display that subsidiary on the directly owns list
   6. User clicks close icon, side panel hides
b. 0. If inactive subsidiary relationship exists, do not display that subsidiary on the directly owns list
c. 0. If subsidiary relationship exists but subsidiary entity is inactive, do not display that subsidiary on the directly owns list
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the subsidiaries tab
And the user clicks on the graph button
When the user clicks on direct relationship only filter checkbox in the graphs
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see list of direct subsidiaries with entity title, country and percentage ownership in directly owns section of side panel for the node user clicked in the graphs

Examples:
|fid|nodeTitle|
|LE-6|QA Legal Entity 6|
|1717|Berliner Volksbank eG|
|200|Public Bank (Hong Kong) Limited|

Scenario: Covers below scenarios
A. 0. If active relationship to person owner exists for legal entity user selected or any entity in its path of ownership, display that person in the UBO list and display the legal title of the entity it directly owns
   1. If inactive relationship to person owner exists for legal entity user selected or any entity in its path of ownership, do not display that person in the UBO list
   2. If multiple people appear in the UBO list, sort by percent ownership first then by name
   3. If UBO relationship has percent ownership, display next to person on UBO list
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the subsidiaries tab
And the user clicks on the graph button
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see list of ubos with name, entity and percentage ownership in ubo section of side panel for the node <nodeTitle> user clicked in the graphs
|UBO NAME|ENTITY|PERCENTAGE OWNERSHIP|
|QA Test Person C|QA Legal Entity D|50.52|
|QA Test Person H|QA Legal Entity D|49.23|
|QA Test Person G|QA Legal Entity D|4.23|

Examples:
|fid|nodeTitle|
|LE-D|QA Legal Entity D|

Scenario: display "No Known Entities" if there are no direct subsidiaries
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the subsidiaries tab
And the user clicks on the graph button
When the user clicks on direct relationship only filter checkbox in the graphs
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see message displayed in side panel in place of list explaining there are no directly owned entities in the graphs

Examples:
|fid|nodeTitle|
|LE-6|QA Legal Entity 34|

Scenario: Covers below scenarios
a. 0. Display "No Known Entities" under ubo section for kyc user
   1. User clicks on another node, side panel should refresh with updated information
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the subsidiaries tab
And the user clicks on the graph button
And the user resize graph to translate(886.5,58) scale(0.9910000000000001)
When the user clicks on direct relationship only filter checkbox in the graphs
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
Then the user should see message displayed in side panel in place of list explaining there are no ultimate beneficial owners in the graphs
When the user clicks on the tile of the another legal entity <switchNode> (including the entity of interest) in the graphs
Then the user should see complete head office address, regulators , stock exchanges and website in details section of side panel for the node user clicked in the graphs

Examples:
|fid|nodeTitle|switchNode|
|112618|Moody Bank Holding Company Inc|Moody National Bank|

Scenario: User is taken to the owners graph when clicks legal entity's title link in the side panel
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
When the user clicks on direct relationship only filter checkbox in the graphs
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
And the user clicks on the legal entity title <nodeTitle> on the side panel in the graphs
Then user is taken to the respective graph page of that legal entity <nodeTitle>
Then the user should see the legal entity <legalEntity>, user is currently viewing, as the root and highlighted on the graphs

Examples:
|fid|nodeTitle|legalEntity|
|LE-6|QA Legal Entity 10|QA Legal Entity 10|
|LE-6|QA Legal Entity 6|QA Legal Entity 6|

Scenario: User is taken to the subs graph when clicks legal entity's title link in the side panel
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the subsidiaries tab
And the user clicks on the graph button
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
And the user clicks on the legal entity title <nodeTitle> on the side panel in the graphs
Then user is taken to the respective graph page of that legal entity <nodeTitle>
Then the user should see the legal entity <legalEntity>, user is currently viewing, as the root and highlighted on the graphs

Examples:
|fid|nodeTitle|legalEntity|
|LE-6|QA Legal Entity 35|QA Legal Entity 35|
|LE-6|QA Legal Entity 6|QA Legal Entity 6|

Scenario: User is taken to the full graph when clicks legal entity's title link in the side panel
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the group structure tab
And the user clicks on the graph button
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
And the user clicks on the legal entity title <nodeTitle> on the side panel in the graphs
Then the user should see the side panel closed and should be able to continue in the graphs
Then user is taken to the respective graph page of that legal entity <nodeTitle>
Then the user should see the legal entity <legalEntity>, user is currently viewing, as the root and highlighted on the graphs

Examples:
|fid|nodeTitle|legalEntity|
|LE-6|QA Legal Entity 10|QA Legal Entity 10|

Scenario: Verify person, non-person or non-entity are not clickable
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
When the user clicks on the person, non-person or non-entity graph node with title <nodeTitle>, user is currently viewing in the graph
Then the user should not see the side panel for the person, non-person or non-entity in the graphs

Examples:
|fid|nodeTitle|
|LE-6|QA Test Person 1|
|LE-6|Others|

Scenario: If multiple websites are present, then display one website, whichever is found first on the details section of side panel
When the user opens legal entity <fid>
When the user clicks on the ownership tab
And the user clicks on the owners tab
And the user clicks on the graph button
When the user clicks on direct relationship only filter checkbox in the graphs
And the user clicks on the tile of the legal entity <nodeTitle> (including the entity of interest) in the graphs
When the user clicks on <website> link in the entity details section of side panel
Then user is taken to a URL http://www.bip.b.br/ that opens in a new window

Examples:
|fid|nodeTitle|website|
|732|Banco Indusval SA|http://www.bip.b.br|

Scenario: KYC user logout
Meta: @id logout
Given the user is on the ubo login page
When the user logout