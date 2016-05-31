Epic: Ownership, Subsidiaries, Full Graph

Covers below features:
JIRA ID - KYC-147 pop open panel for more entity info on owners graph

Scenario: View side panel for legal entity on owners graph
a. User clicks title of legal entity on node (could be owner on graph or root node), side panel opens with more details about the entity
b. With head office address elements with varying "UseInAddress" flag value true for each element (display element if UseInAddress is true)
c. With head office address elements with varying "UseInAddress" flag value false for each element (do not display element if UseInAddress is false)
d. If no primary physical address exists for head office, display field label but no value
e. Active regulation relationships exist for entity user is viewing, display in entity details summary section sorted alphabetically by legal title
f. If only inactive regulation relationship exists, then display field label but no value
g. If no regulation relationship exists, then display field label but no value
h. If no stock exchange relationship exists, display field label in summary section but no value
i. If no stock exchange relationship exists, display field label in identifier section but no value
j. If regulation relationship is inactive, then display field label but no value
k. If active stock exchange relationship(s) exist, display legal title of stock exchange sort first by primary = true, then by legal title
l. If inactive stock exchange relationship, then display field label but no value
m. If no stock exchange relationship exists, display field label but no value
n. If active subsidiary relationship exists, display that subsidiary on the directly owns list
o. If multiple active subsidiary relationships exist and are displayed on list, order by percent ownership first then by legal title
p. If inactive subsidiary relationship exists, do not display that subsidiary on the directly owns list
q. If subsidiary relationship exists but subsidiary entity is inactive, do not display that subsidiary on the directly owns list
r. If no valid subsidiary relationships exist, display directly owns header and display message "No known entities." in place of list
s. If percent ownership exists for subsidiary relationship, display in list next to subsidiary
t. If percent ownership is null, do not display a percent ownership next to subsidiary on list
u. If country of operations exists for subsidiary entity, display next to subsidiary on list
v. If country of operations does not exist for subsidiary entity, do not display next to subsidiary on list
w. Do not display UBO list for KYC user or header for the list
x. User clicks close icon, side panel hides
y. User clicks someplace else on screen outside of side panel, panel does not close
